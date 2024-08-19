import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morse_code/domain/bloc/audio_cubit.dart/audio_cubit.dart';
import 'package:morse_code/domain/bloc/favorites_action_bloc/favorites_action_bloc.dart';
import 'package:morse_code/domain/bloc/favorites_phrases_cubit/favorites_phrases_cubit.dart';
import 'package:morse_code/domain/bloc/translator_bloc/translator_bloc.dart';
import 'package:morse_code/domain/bloc/translator_resume_cubit/translator_resume_cubit.dart';
import 'package:morse_code/domain/models/translator_resume.dart';
import 'package:morse_code/gen/assets.gen.dart';
import 'package:morse_code/injection.dart';
import 'package:morse_code/logger.dart';
import 'package:morse_code/presentation/design/design_appbar.dart';
import 'package:morse_code/presentation/design/design_dialogs.dart';
import 'package:morse_code/presentation/design/scaling_button.dart';
import 'package:morse_code/presentation/favorites_screen/favorites_screen.dart';
import 'package:morse_code/presentation/translator_screen/translator_screen.dart';

part 'widgets/home_screen_bottom_bar.dart';
part 'widgets/tab_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin, WidgetsBindingObserver {
  final _activeTabNotifier =
      ValueNotifier<HomeScreenTab>(HomeScreenTab.translateTab);

  late final TabController _tabController;

  final _mainTextController = TextEditingController();
  final _bottomTextController = TextEditingController();

  final _favoritesBloc = getIt.get<FavoritesActionBloc>();
  final _phrasesCubit = getIt.get<FavoritesPhrasesCubit>();
  final _translatorBloc = getIt.get<TranslatorBloc>();
  final _resumeCubit = getIt.get<TranslatorResumeCubit>();
  final _audioCubit = getIt.get<AudioCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(
      length: HomeScreenTab.values.length,
      vsync: this,
    );
    _initListener();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      _audioCubit.stop();
    }

  }

  void _initListener() {
    _tabController.addListener(_tabListener);
  }

  void _tabListener() {
    _activeTabNotifier.value = HomeScreenTab.values[_tabController.index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DesignAppbar(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              MultiBlocProvider(
                providers: [
                  BlocProvider<FavoritesActionBloc>.value(value: _favoritesBloc),
                  BlocProvider<FavoritesPhrasesCubit>.value(value: _phrasesCubit),
                  BlocProvider<TranslatorBloc>.value(value: _translatorBloc),
                  BlocProvider<TranslatorResumeCubit>.value(value: _resumeCubit),
                  BlocProvider<AudioCubit>.value(value: _audioCubit),
                ],
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<TranslatorBloc, TranslatorState>(
                        bloc: _translatorBloc,
                        listener: (_, state) {
                          switch (state) {
                            case TranslatorStateError err: logger.e(err);
                            case TranslatorStateReady ready:
                              _translateListener(
                                ready.originalText,
                                ready.morseText,
                                _resumeCubit.currentResume,
                              );
                            default:
                              () {};
                          }
                        }),
                    BlocListener<TranslatorResumeCubit, TranslatorResume>(
                      bloc: _resumeCubit,
                      listener: (_, resume) => _translateListener(
                        _translatorBloc.currentOriginal,
                        _translatorBloc.currentMorse,
                        resume,
                      ),
                    ),
                    BlocListener<FavoritesActionBloc, FavoritesActionState>(
                      listener: (_, actionState) {
                        if (actionState is FavoritesActionStateAddedSuccess) {
                          _onSuccessAdded();
                        }
                      },
                    )
                  ],
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: HomeScreenTab.values.map((e) => _getTab(e)).toList()),
                ),
              ),
              Positioned(
                bottom: 17.0,
                left: 0.0,
                right: 0.0,
                child: _HomeScreenBottomBar(
                  onTapTapped: (tab) => _onTapTapped(tab),
                  activeTabListenable: _activeTabNotifier,
                ))
            ],
          ),
        ),
      ),
    );
  }

  void _translateListener(
    String originalText,
    String morseText,
    TranslatorResume resume,
  ) {
    final (mainText, bottomText) = switch (resume) {
      TranslatorResume.textToMorse => (originalText, morseText),
      TranslatorResume.morseToText => (morseText, originalText),
    };
    if (_mainTextController.value.text != mainText) {
      _mainTextController.text = replaceDotsAndDash(mainText);
    }

    if (_bottomTextController.value.text != bottomText) {
      _bottomTextController.text = replaceDotsAndDash(bottomText);
    }
  }

  void _onTapTapped(HomeScreenTab tab) {
    _tabController.animateTo(tab.tabIndex);
  }

  Widget _getTab(HomeScreenTab tab) => switch (tab) {
        HomeScreenTab.translateTab => TranslatorScreen(
            mainController: _mainTextController,
            bottomController: _bottomTextController,
          ),
        HomeScreenTab.favoritesTab => FavoritesScreen(
          onCardTapped: () => _onTapTapped(HomeScreenTab.translateTab),
        ),
      };

  void _onSuccessAdded() {
    _translatorBloc.add(TranslatorClearEvent());
    if (!mounted) return;
    DesignDialogs.showSnackbar(context, text: 'Successfully added to saved translations');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _activeTabNotifier.dispose();
    _tabController.removeListener(_tabListener);
    _tabController.dispose();
    _mainTextController.dispose();
    _bottomTextController.dispose();
    super.dispose();
  }
}

enum HomeScreenTab {
  translateTab,
  favoritesTab,
}

extension HomeScreenTabExtension on HomeScreenTab {
  String get iconPath => switch (this) {
        HomeScreenTab.translateTab => Assets.images.translateTab.path,
        HomeScreenTab.favoritesTab => Assets.images.favoritesTab.path,
      };

  int get tabIndex => switch (this) {
        HomeScreenTab.translateTab => 0,
        HomeScreenTab.favoritesTab => 1,
      };

  HomeScreenTab getByIndex(int index) {
    if (index == 0) {
      return HomeScreenTab.translateTab;
    } else {
      return HomeScreenTab.favoritesTab;
    }
  }
}
