part of '../translator_screen.dart';

class _BottomTextCard extends StatefulWidget {
  final TextEditingController textController;
  final ValueListenable<SupLocale> localeListenable;
  final VoidCallback onSpeakButtonTap;
  final VoidCallback onClearButtonTap;
  final VoidCallback copyToClipboard;
  final VoidCallback onFavoritesButtonTap;
  final VoidCallback onTranslateButtonTap;

  const _BottomTextCard({
    required this.textController,
    required this.localeListenable,
    required this.onClearButtonTap,
    required this.onSpeakButtonTap,
    required this.copyToClipboard,
    required this.onFavoritesButtonTap,
    required this.onTranslateButtonTap,
  });

  @override
  State<_BottomTextCard> createState() => __BottomTextCardState();
}

class __BottomTextCardState extends State<_BottomTextCard> {

  late final TextEditingController _textController;

  @override
  void initState() {
    _textController = widget.textController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CardDecoration(
      padding: const EdgeInsets.only(left: 16, right: 6.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CardTitleWidget(
            cardType: _CardType.bottom, 
            localeListenable: widget.localeListenable, 
            onSpeakButtonTap: () => widget.onSpeakButtonTap.call(), 
            onClearButtonTap: () => widget.onClearButtonTap.call(),
          ),
          _CardTextField(
            cardType: _CardType.bottom,
            textEditingController: _textController,
          ),
          const Gap(16.0),
          _CardBottomButtons(
            cardType: _CardType.bottom, 
            onClipboardButtonTap: () => widget.onClearButtonTap.call(), 
            onFavoriteButtonTap: () => widget.onFavoritesButtonTap.call(), 
            onTranslateButtonTap: () => widget.onTranslateButtonTap.call(),
          ),
          const Gap(16.0),
        ],
      ),
    );
  }


  Widget _bottomButtonsWidget() => Container();
}