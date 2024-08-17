import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:morse_code/domain/models/sup_locale.dart';
import 'package:morse_code/domain/models/translator_resume.dart';
import 'package:morse_code/gen/assets.gen.dart';
import 'package:morse_code/presentation/application/application.dart';
import 'package:morse_code/presentation/design/card_decoration.dart';
import 'package:morse_code/presentation/design/desing_title_text.dart';
import 'package:morse_code/presentation/design/scaling_button.dart';

part 'widgets/swap_widget.dart';
part 'widgets/swap_button.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final _currentSupLocaleNotifier = ValueNotifier<SupLocale>(SupLocale.enEN);
  final _translatorResumeNotifier =
      ValueNotifier<TranslatorResume>(TranslatorResume.textToMorse);

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
            CardDecoration(
                child: Container(
              constraints: const BoxConstraints(minHeight: 140),
            )),
            const Gap(16),
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
    super.dispose();
  }
}
