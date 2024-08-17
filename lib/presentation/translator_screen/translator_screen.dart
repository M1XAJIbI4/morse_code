import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:morse_code/domain/bloc/translator_bloc/translator_bloc.dart';
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
// part 'widgets/sound_button.dart';
part 'widgets/main_text_card.dart';
part 'widgets/translate_button.dart';
part 'widgets/assets_icon_button.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final _currentSupLocaleNotifier = ValueNotifier<SupLocale>(SupLocale.enEN);
  final _translatorResumeNotifier =
      ValueNotifier<TranslatorResume>(TranslatorResume.textToMorse);

  final _textController = TextEditingController();

  late final TranslatorBloc _translatorBloc;

  @override
  void initState() {
    super.initState();
    _translatorBloc = context.read<TranslatorBloc>();
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
              resumeListenable: _translatorResumeNotifier,
              onSwapPressed: () => _onSwapPressed(),
            ),
            const Gap(16),
            // top card
            _MainTextCard(
              translatorResumeListenable: _translatorResumeNotifier, 
              localeListenable: _currentSupLocaleNotifier,
              textController: _textController,
            ),
            const Gap(16),
      
            // bottom cart (for translated text)
            CardDecoration(
                child: Container(
              constraints: const BoxConstraints(minHeight: 140),
            )),
          ],
        ),
      ),
    );
  }

  void _changeLocale() {}

  void _onSwapPressed() {
    final newValue =
        _translatorResumeNotifier.value == TranslatorResume.textToMorse
            ? TranslatorResume.morseToText
            : TranslatorResume.textToMorse;
    _translatorResumeNotifier.value = newValue;
  }

  @override
  void dispose() {
    _currentSupLocaleNotifier.dispose();
    _textController.dispose();
    super.dispose();
  }
}

class _TranslatedTextCard extends StatelessWidget {
  const _TranslatedTextCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}