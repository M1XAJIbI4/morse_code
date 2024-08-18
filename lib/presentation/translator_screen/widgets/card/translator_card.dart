part of '../../translator_screen.dart';

class _TranslatorCard extends StatefulWidget {
  final _CardType cardType;
  final TextEditingController textController;
  final ValueListenable<SupLocale> localeListenable;
  final VoidCallback onClearButtonTap;
  final VoidCallback onSpeakButtonTap;
  final VoidCallback copyToClipboard;
  final VoidCallback onFavoritesButtonTap;
  final VoidCallback onTranslateButtonTap;

  const _TranslatorCard({
    required this.cardType,
    required this.textController,
    required this.localeListenable,
    required this.onClearButtonTap,
    required this.onSpeakButtonTap,
    required this.copyToClipboard,
    required this.onFavoritesButtonTap,
    required this.onTranslateButtonTap,
  });

  @override
  State<_TranslatorCard> createState() => _TranslatorCardState();
}

class _TranslatorCardState extends State<_TranslatorCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CardDecoration(
        padding: const EdgeInsets.only(left: 16, right: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CardTitleWidget(
              cardType: widget.cardType,
              localeListenable: widget.localeListenable,
              onSpeakButtonTap: () => widget.onSpeakButtonTap.call(),
              onClearButtonTap: () => widget.onClearButtonTap.call(),
              key: ValueKey('title${widget.cardType}'),
            ),
            BlocBuilder<TranslatorResumeCubit, TranslatorResume>(
              bloc: context.read<TranslatorResumeCubit>(),
              builder: (_, resume) => _CardTextField(
                cardType: widget.cardType,
                textEditingController: widget.textController,
                resume: resume,
                key: ValueKey('textField${widget.cardType}'),
              ),
            ),
            const Gap(16.0),
            _CardBottomButtons(
              cardType: widget.cardType,
              onClipboardButtonTap: () => widget.copyToClipboard.call(),
              onFavoriteButtonTap: () => widget.onFavoritesButtonTap.call(),
              onTranslateButtonTap: () => widget.onTranslateButtonTap.call(),
              key: ValueKey('bottomButtons${widget.cardType}'),
            ),
            const Gap(16.0),
          ],
        ),
      ),
    );
  }
}
