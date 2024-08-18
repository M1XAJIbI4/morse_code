part of '../translator_screen.dart';

class _MainTextCard extends StatefulWidget {
  final TextEditingController textController;
  final ValueListenable<SupLocale> localeListenable;
  final VoidCallback onClearTap;
  final VoidCallback copyToClipboard;
  final VoidCallback onSpeakButtonTap;
  final VoidCallback onFavoritesButtonTap;

  const _MainTextCard({
    required this.textController,
    required this.localeListenable,
    required this.onClearTap,
    required this.copyToClipboard,
    required this.onSpeakButtonTap,
    required this.onFavoritesButtonTap,
  });

  @override
  State<_MainTextCard> createState() => _MainTextCardState();
}

class _MainTextCardState extends State<_MainTextCard> {
  late final TextEditingController _textController;
  late final TranslatorBloc _translatorBloc;
  late final TranslatorResumeCubit _translatorResumeCubit;

  @override
  void initState() {
    _translatorBloc = context.read<TranslatorBloc>();
    _translatorResumeCubit = context.read<TranslatorResumeCubit>();
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
            cardType: _CardType.main, 
            localeListenable: widget.localeListenable, 
            onSpeakButtonTap: () => widget.onSpeakButtonTap.call(), 
            onClearButtonTap: () => widget.onClearTap.call(),
            key: const ValueKey(_CardType.main),
          ),
          _CardTextField(
            cardType: _CardType.main, 
            textEditingController: widget.textController,
          ),
          const Gap(16.0),
          _CardBottomButtons(
            cardType: _CardType.main, 
            onClipboardButtonTap: () => widget.copyToClipboard.call(), 
            onFavoriteButtonTap: () => widget.onFavoritesButtonTap.call(), 
            onTranslateButtonTap: _onTranslateTap,
          ),


          // _bottomButtonsWidget(),
          const Gap(16.0),
        ],
      ),
    );
  }

  void _onTranslateTap() {
    final text = _getCurrentText();
    print('FOBOAR UI TE - $text');
    if (text.isNotEmpty && text != _translatorBloc.currentOriginal) {
      _translatorBloc.add(TranslatorTranslateEvent(
        text: text,
        resume: _currentResume,
      ));
    }
  }

  String _getCurrentText() => _textController.value.text;

  TranslatorResume get _currentResume => _translatorResumeCubit.state;
}
