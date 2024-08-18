part of '../../translator_screen.dart';

class _CardBottomButtons extends StatelessWidget {
  final _CardType cardType;
  final VoidCallback onClipboardButtonTap;
  final VoidCallback onTranslateButtonTap;
  final VoidCallback onFavoriteButtonTap;

  const _CardBottomButtons({
    required this.cardType,
    required this.onClipboardButtonTap,
    required this.onFavoriteButtonTap,
    required this.onTranslateButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(),
        _AssetsIconButton(
          onPressed: () => onClipboardButtonTap.call(),
          iconPath: Assets.images.copyIcon.path,
        ),
        const Gap(10.0),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: cardType == _CardType.main
              ? _TranslateButton(
                  onTranslatePressed: () => onTranslateButtonTap.call())
              : _AssetsIconButton(
                  onPressed: () => onFavoriteButtonTap.call(),
                  iconPath: Assets.images.starIcon.path,
                ),
        ),
        // Container(),
      ],
    );
  }
}
