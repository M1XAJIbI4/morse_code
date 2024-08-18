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
        Stack(
          alignment: Alignment.center,
          children: [
            BlocBuilder<TranslatorResumeCubit, TranslatorResume>(
              bloc: context.read<TranslatorResumeCubit>(),
              builder: (_, resume) {
                return BlocBuilder<AudioCubit, AudioState>(
                bloc: context.read<AudioCubit>(),
                builder: (_, state) {
                  final (isPlayingUsual, isPlayingMorse) = (
                    state.isPlayingUsualText, 
                    state.isPlayingMorseText,
                  );
                  logger.d("SOUND STATE usual: $isPlayingUsual  morse: $isPlayingMorse");

                  final isIlluminated = _isIlluminatedButton(
                    isPlayingMorse: isPlayingMorse,
                    isPlayingUsual: isPlayingUsual,
                    resume: resume,
                    cardType: cardType,
                  );
              
                  return Transform.translate(
                    offset: const Offset(-1.0, 0.0),
                    child: AnimatedContainer(
                      width: 30,
                      height: 30,
                      duration: const Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isIlluminated 
                            ? ApplicationTheme.APPBAR_COLOR.withOpacity(0.15) 
                            : Colors.transparent
                      ),
                    ),
                  );
                },
              );
              },
            ),
            _AssetsIconButton(
              onPressed: () => onSpeakButtonTap.call(),
              iconPath: Assets.images.speakIcon.path,
              overlayColor: Colors.transparent,
            ),
          ],
        ),
        const Spacer(),
        BlocBuilder<TranslatorResumeCubit, TranslatorResume>(
          bloc: context.read<TranslatorResumeCubit>(),
          builder: (_, resume) {
            final isShow = _isShowClearButton(resume, cardType);
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: isShow
                  ? _AssetsIconButton(
                      onPressed: () => onClearButtonTap.call(),
                      iconPath: Assets.images.closeIcon.path,
                    )
                  : const SizedBox(),
            );
          },
        ),
      ],
    );
  }

  bool _isIlluminatedButton({
    required bool isPlayingUsual,
    required bool isPlayingMorse,
    required _CardType cardType,
    required TranslatorResume resume,
  }) {
    bool result = false;
    if (isPlayingUsual) {
      result = ((cardType == _CardType.main) && resume == TranslatorResume.textToMorse) || 
                        (cardType == _CardType.bottom && resume == TranslatorResume.morseToText);

    } else if (isPlayingMorse) {
      result = ((cardType == _CardType.bottom) && resume == TranslatorResume.textToMorse) ||
                        (cardType == _CardType.main && resume == TranslatorResume.morseToText);
    }
    return result;
  }

  bool _isShowClearButton(
    TranslatorResume resume,
    _CardType cardType,
  ) =>
      switch (resume) {
        TranslatorResume.textToMorse => cardType == _CardType.main,
        TranslatorResume.morseToText => cardType != _CardType.main,
      };
}
