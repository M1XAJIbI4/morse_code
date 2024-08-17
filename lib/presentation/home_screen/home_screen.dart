import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morse_code/domain/bloc/favorites_action_bloc/favorites_action_bloc.dart';
import 'package:morse_code/domain/bloc/favorites_phrases_cubit/favorites_phrases_cubit.dart';
import 'package:morse_code/domain/bloc/translator_bloc/translator_bloc.dart';
import 'package:morse_code/domain/bloc/translator_resume_cubit/translator_resume_cubit.dart';
import 'package:morse_code/gen/assets.gen.dart';
import 'package:morse_code/injection.dart';
import 'package:morse_code/presentation/design/design_appbar.dart';
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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _activeTabNotifier = ValueNotifier<HomeScreenTab>(HomeScreenTab.translateTab);
  
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: HomeScreenTab.values.length,
      vsync: this,
    );
    _initListener();
  }

  void _initListener() {
    //TODO: implement
    // _tabController.animation?.addListener(() {
    //   final value = _tabController.animation?.value;
    //   final offset = _tabController.offset;
    //   print('FOOBAR value - $value $offset');
    // });
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
            print('FOOBAR on tap');
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              MultiBlocProvider(
                providers: [
                  BlocProvider<FavoritesActionBloc>(create: (ctx) => getIt.get<FavoritesActionBloc>()),
                  BlocProvider<FavoritesPhrasesCubit>(create: (ctx) => getIt.get<FavoritesPhrasesCubit>()),
                  BlocProvider<TranslatorBloc>(create: (ctx) => getIt.get<TranslatorBloc>()),
                  BlocProvider<TranslatorResumeCubit>(create: (ctx) => getIt.get<TranslatorResumeCubit>()),
                ],
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: HomeScreenTab.values.map((e) => _getTab(e)).toList()),
              ),
              Positioned(
                bottom: 17.0,
                left: 0.0,
                right: 0.0,
                child: _HomeScreenBottomBar(
                  onTapTapped: (tab) => _onTapTapped(tab), 
                  activeTabListenable: _activeTabNotifier,
                )
              )
            ],
          ),
        ),
      ),
    );
  }


  void _onTapTapped(HomeScreenTab tab) {
    _tabController.animateTo(tab.tabIndex);
  }

  Widget _getTab(HomeScreenTab tab) => switch (tab) {
    HomeScreenTab.translateTab => const TranslatorScreen(),
    HomeScreenTab.favoritesTab => const FavoritesScreen(),
  };

  @override
  void dispose() {
    _activeTabNotifier.dispose();
    _tabController.removeListener(_tabListener);
    _tabController.dispose();
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
