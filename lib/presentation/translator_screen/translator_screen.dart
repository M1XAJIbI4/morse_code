import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:morse_code/domain/bloc/translator_bloc/translator_bloc.dart';
import 'package:morse_code/domain/bloc/translator_resume_cubit/translator_resume_cubit.dart';
import 'package:morse_code/domain/models/sup_locale.dart';
import 'package:morse_code/domain/models/translator_resume.dart';
import 'package:morse_code/gen/assets.gen.dart';
import 'package:morse_code/gen/fonts.gen.dart';
import 'package:morse_code/presentation/application/application.dart';
import 'package:morse_code/presentation/design/card_decoration.dart';
import 'package:morse_code/presentation/design/desing_title_text.dart';
import 'package:morse_code/presentation/design/morse_text.dart';
import 'package:morse_code/presentation/design/scaling_button.dart';

part 'widgets/swap_widget.dart';
part 'widgets/swap_button.dart';
part 'widgets/translate_button.dart';
part 'widgets/assets_icon_button.dart';
part 'widgets/card/card_title_widget.dart';
part 'widgets/card/card_text_field.dart';
part 'widgets/card/card_bottom_buttons.dart';

part 'widgets/card/translator_card.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final _currentSupLocaleNotifier = ValueNotifier<SupLocale>(SupLocale.enEN);

  final _mainTextContoller = TextEditingController();
  final _bottomTextController = TextEditingController();

  late final TranslatorBloc _translatorBloc;
  late final TranslatorResumeCubit _translatorResumeCubit;

  @override
  void initState() {
    super.initState();
    _translatorBloc = context.read<TranslatorBloc>();
    _translatorResumeCubit = context.read<TranslatorResumeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TranslatorBloc, TranslatorState>(
            bloc: _translatorBloc,
            listener: (_, state) {
              switch (state) {
                //TODO: implement
                case TranslatorStateError _: print('FO ERROR ');
                case TranslatorStateReady ready:
                  _translateListener(
                    ready.originalText,
                    ready.morseText,
                    _translatorResumeCubit.currentResume,
                  );
                default:
                  () {};
              }
            }),
        BlocListener<TranslatorResumeCubit, TranslatorResume>(
          bloc: _translatorResumeCubit,
          listener: (_, resume) => _translateListener(
            _translatorBloc.currentOriginal,
            _translatorBloc.currentMorse,
            resume,
          ),
        )
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20) +
              const EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SwapWidget(
                onLocalePressed: () => _changeLocale(),
                localeListenable: _currentSupLocaleNotifier,
                onSwapPressed: () => _onSwapPressed(),
              ),
              ..._CardType.values.map((cardType) {
                return _TranslatorCard(
                  cardType: cardType,
                  textController: _getControllerByCartType(cardType),
                  localeListenable: _currentSupLocaleNotifier,
                  onClearButtonTap: _onClearTap,
                  onSpeakButtonTap: () => _onSpeakButtonTap(cardType),
                  copyToClipboard: () => _copyToClipboard(cardType),
                  onFavoritesButtonTap: () =>
                      print('FOBOAR on favorites button tap'),
                  onTranslateButtonTap: () => print('TRANSLATE'),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController _getControllerByCartType(_CardType type) {
    return switch (type) {
      _CardType.main => _mainTextContoller,
      _CardType.bottom => _bottomTextController,
    };
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
    if (_mainTextContoller.value.text != mainText) {
      _mainTextContoller.text = mainText;
    }

    if (_bottomTextController.value.text != bottomText) {
      _bottomTextController.text = bottomText;
    }
  }

  void _changeLocale() {}

  void _onSwapPressed() => _translatorResumeCubit.changeResume();

  void _onClearTap() => _translatorBloc.add(TranslatorClearEvent());

  void _onSpeakButtonTap(_CardType type) {
    // final text = _getTextControllerTextByType(type);
    //TODO: imaplement
  }

  Future<void> _copyToClipboard(_CardType type) async {
    //TODO: implement
    final text = _getTextControllerTextByType(type);
    if (text.isEmpty) return;

    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ApplicationTheme.APPBAR_COLOR,
      content: Center(
        child: DesignTitleText(
          text: 'Text copied to clipboard $text',
          color: Colors.white,
        ),
      ),
    ));
  }

  String _getTextControllerTextByType(_CardType type) => switch (type) {
    _CardType.main => _mainTextContoller.value.text,
    _CardType.bottom => _bottomTextController.value.text,
  };

  @override
  void dispose() {
    _currentSupLocaleNotifier.dispose();
    _mainTextContoller.dispose();
    _bottomTextController.dispose();
    super.dispose();
  }
}

enum _CardType {
  main,
  bottom,
}
