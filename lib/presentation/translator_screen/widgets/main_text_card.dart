part of '../translator_screen.dart';


class _MainTextCard extends StatefulWidget {
  final TextEditingController textController;
  final ValueListenable<SupLocale> localeListenable;
  final VoidCallback onClearTap;

  const _MainTextCard({
    required this.textController,
    required this.localeListenable,
    required this.onClearTap,
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
          _titleWidget(),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 110),
            child: _textFieldWidget(),
          ),
          const Gap(16.0),
          _bottomButtonsWidget(),
          const Gap(16.0),
        ],
      ),
    );
  }

  Widget _titleWidget() => Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 56,
        child: BlocBuilder<TranslatorResumeCubit, TranslatorResume>(
          bloc: _translatorResumeCubit,
          builder: (_, resume) {
            const textColor = ApplicationTheme.ACTIVE_COLOR;
            return AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child: resume == TranslatorResume.textToMorse 
                  ? _LocaleText(
                        localeListenable: widget.localeListenable, 
                        textColor: textColor,    
                    ) 
                  : const MorseText(color: textColor)
            );
          },
        )
      ),
      const Gap(8.0),
      _AssetsIconButton(onPressed: _onSpeakButtonTap, iconPath: Assets.images.speakIcon.path,),
      const Spacer(),
      _AssetsIconButton(onPressed: _onCloseButtonTap, iconPath: Assets.images.closeIcon.path),
    ],
  );

  Widget _textFieldWidget() => Padding(
    padding: const EdgeInsets.only(right: 10),
    child: TextField(
      controller: _textController,
      cursorColor: ApplicationTheme.APPBAR_COLOR,
      maxLines: null,
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        enabledBorder: UnderlineInputBorder(      
          borderSide: BorderSide(
            color: ApplicationTheme.ACTIVE_COLOR.withOpacity(0.3),
          ),
        ),  
      ),
    ),
  );

  Widget _bottomButtonsWidget() => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Spacer(),
      _AssetsIconButton(
        onPressed: _onClipboardButtonTap, 
        iconPath: Assets.images.copyIcon.path,
      ),
      const Gap(10.0),
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: _TranslateButton(onTranslatePressed: _onTranslateTap),
      ),
      // Container(),
    ],
  );
  
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

  //TODO: implement
  void _onSpeakButtonTap() => print('FOOBAR');

  void _onCloseButtonTap() => widget.onClearTap.call();

  String _getCurrentText() => _textController.value.text;

  TranslatorResume get _currentResume => _translatorResumeCubit.state;

  Future<void> _onClipboardButtonTap() async {
    final text = _getCurrentText();
    if (text.isEmpty) return;

    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: ApplicationTheme.APPBAR_COLOR,
        content: Center(
          child: DesignTitleText(
              text: 'Text copied to clipboard',
              color: Colors.white,
            ),
          ),
        )
    );
  } 
}
