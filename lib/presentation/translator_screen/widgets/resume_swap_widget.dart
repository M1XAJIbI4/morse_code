part of '../translator_screen.dart';

class _ResumeSwapWidget extends StatelessWidget {
  final VoidCallback onLocalePressed;
  final ValueListenable<SupLocale> localeListenable;
  final VoidCallback onSwapPressed;

  const _ResumeSwapWidget({
    required this.onLocalePressed,
    required this.localeListenable,
    required this.onSwapPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: CardDecoration(
        borderRadius: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12) +
            const EdgeInsets.only(top: 11, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 90,
              child: BlocBuilder<TranslatorResumeCubit, TranslatorResume>(
                bloc: context.read<TranslatorResumeCubit>(),
                builder: (_, resume) {
                  final isDefault = resume == TranslatorResume.textToMorse;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: Row(
                      key: ValueKey('left$resume'),
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        isDefault 
                            ? _flagIcon() 
                            : _morseIcon(),
                        const Gap(10),
                        isDefault 
                            ? _LocaleText(localeListenable: localeListenable) 
                            : const MorseText()
                      ],
                    ),
                  );
                }
              )
            ),

            _ResumeSwapButton(
              onPressed: () => onSwapPressed.call()
            ),

            SizedBox(
              width: 90,
              child: BlocBuilder<TranslatorResumeCubit, TranslatorResume>(
                bloc: context.read<TranslatorResumeCubit>(),
                builder: (_, resume) {
                  final isDefault = resume == TranslatorResume.textToMorse;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: Row(
                      key: ValueKey('right$resume'),
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        !isDefault 
                            ? _LocaleText(localeListenable: localeListenable) 
                            : const MorseText(),
                        const Gap(10),
                        !isDefault 
                            ? _flagIcon() 
                            : _morseIcon(),
                      ],
                    ),
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
}

  Widget _morseIcon() => ClipOval(
    child: SvgPicture.asset(Assets.images.morseIcon.path),
  );

  Widget _flagIcon() => SvgPicture.asset(Assets.images.enFlagIcon.path);
}

class _LocaleText extends StatelessWidget {
  final ValueListenable<SupLocale> localeListenable;
  final Color textColor;

  const _LocaleText({
    required this.localeListenable,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SupLocale>(
      valueListenable: localeListenable,
      builder: (_, supLocale, __) => DesignTitleText(
        text: supLocale.title,
        color: textColor,
      ),
    );
  }
}
