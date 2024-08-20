// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:morse_code/domain/bloc/audio_cubit.dart/audio_cubit.dart';
import 'package:morse_code/domain/bloc/favorites_action_bloc/favorites_action_bloc.dart';
import 'package:morse_code/domain/bloc/translator_bloc/translator_bloc.dart';
import 'package:morse_code/domain/bloc/translator_resume_cubit/translator_resume_cubit.dart';
import 'package:morse_code/domain/models/sup_locale.dart';
import 'package:morse_code/domain/models/translator_resume.dart';
import 'package:morse_code/gen/assets.gen.dart';
import 'package:morse_code/gen/fonts.gen.dart';
import 'package:morse_code/logger.dart';
import 'package:morse_code/presentation/application/application.dart';
import 'package:morse_code/presentation/design/card_decoration.dart';
import 'package:morse_code/presentation/design/design_dialogs.dart';
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
  final TextEditingController mainController;
  final TextEditingController bottomController;

  const TranslatorScreen({
    required this.bottomController,
    required this.mainController,
    super.key,
  });

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final _currentSupLocaleNotifier = ValueNotifier<SupLocale>(SupLocale.enEN);

  late final TextEditingController _mainTextContoller;
  late final TextEditingController _bottomTextController;

  late final TranslatorBloc _translatorBloc;
  late final TranslatorResumeCubit _translatorResumeCubit;
  late final FavoritesActionBloc _actionBloc;
  late final AudioCubit _audioCubit;

  @override
  void initState() {
    super.initState();
    _mainTextContoller = widget.mainController;
    _bottomTextController = widget.bottomController;
    _translatorBloc = context.read<TranslatorBloc>();
    _translatorResumeCubit = context.read<TranslatorResumeCubit>();
    _actionBloc = context.read<FavoritesActionBloc>();
    _audioCubit = context.read<AudioCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                onFavoritesButtonTap: _onFavoritesButtonTap,
                onTranslateButtonTap: _onTranslateTap,
              );
            })
          ],
        ),
      ),
    );
  }


  void _changeLocale() {}

  void _onTranslateTap() {
    final resume = _translatorResumeCubit.currentResume;
    final text = _mainTextContoller.value.text;
    if (text.isNotEmpty) {
      _translatorBloc.add(
        TranslatorTranslateEvent(text: text, resume: resume),
      );
      FocusScope.of(context).unfocus();
      
    } else {
      _translatorBloc.add(TranslatorClearEvent());
    }
  }

  void _onSwapPressed() => _translatorResumeCubit.changeResume();

  void _onClearTap() {
    _translatorBloc.add(TranslatorClearEvent());
    _audioCubit.stop();
  }

  void _onSpeakButtonTap(_CardType type) {
    final text = _getTextControllerTextByType(type);
    if (text.isEmpty) return;

    final resume = _translatorResumeCubit.state;
    final isMorseText = switch (type) {
      _CardType.main => resume == TranslatorResume.morseToText,
      _CardType.bottom => resume == TranslatorResume.textToMorse,
    };

    _audioCubit.play(text: text, isMorseText: isMorseText); 
  }

  Future<void> _copyToClipboard(_CardType type) async {
    final text = _getTextControllerTextByType(type);
    if (text.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    DesignDialogs.showSnackbar(context, text: 'Text copied to clipboard');
  }

  void _onFavoritesButtonTap() {
    final resume = _translatorResumeCubit.state;
    final texts = (
        _mainTextContoller.value.text, 
        _bottomTextController.value.text,
    );
    
    if (texts.$1.isNotEmpty && texts.$2.isNotEmpty) {
      _actionBloc.add(
        FavoritesActionAddPhraseEvent(
          originalText: resume == TranslatorResume.textToMorse ? texts.$1 : texts.$2,
          morseText: resume == TranslatorResume.morseToText ? texts.$1 : texts.$2,
        ),
      );
      _audioCubit.stop();
    }
  }

  TextEditingController _getControllerByCartType(_CardType type) {
    return switch (type) {
      _CardType.main => _mainTextContoller,
      _CardType.bottom => _bottomTextController,
    };
  }

  String _getTextControllerTextByType(_CardType type) => switch (type) {
        _CardType.main => _mainTextContoller.value.text,
        _CardType.bottom => _bottomTextController.value.text,
      };

  @override
  void dispose() {
    _currentSupLocaleNotifier.dispose();
    _audioCubit.close();
    super.dispose();
  }
}

enum _CardType {
  main,
  bottom,
}

String replaceDotsAndDash(String value) {
  return value.replaceAll('…', '...').replaceAll('-', '—');
}
