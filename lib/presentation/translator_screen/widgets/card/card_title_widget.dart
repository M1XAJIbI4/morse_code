part of '../../translator_screen.dart';


class _CardTitleWidget extends StatelessWidget {
  final _CardType cardType;
  final ValueListenable<SupLocale> localeListenable;
  final VoidCallback onSpeakButtonTap;
  final VoidCallback onClearButtonTap;


  const _CardTitleWidget({
    required this.cardType,
    required this.localeListenable,
    required this.onSpeakButtonTap,
    required this.onClearButtonTap,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
            width: 56,
            child: BlocBuilder<TranslatorResumeCubit, TranslatorResume>(
              bloc: context.read<TranslatorResumeCubit>(),
              builder: (_, resume) {
                const textColor = ApplicationTheme.ACTIVE_COLOR;
                final defaultResumeForThisCard = switch (cardType) {
                  _CardType.main => TranslatorResume.textToMorse,
                  _CardType.bottom => TranslatorResume.morseToText,
                };
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  child: resume == defaultResumeForThisCard
                      ? _LocaleText(
                          localeListenable: localeListenable,
                          textColor: textColor,
                        )
                      : const MorseText(color: textColor));
              },
            )),
        const Gap(8.0),
        _AssetsIconButton(
          onPressed: () => onSpeakButtonTap.call(),
          iconPath: Assets.images.speakIcon.path,
        ),
        const Spacer(),
        _AssetsIconButton(
            onPressed: () => onClearButtonTap.call(),
            iconPath: Assets.images.closeIcon.path),
      ],
    );
  }
}
