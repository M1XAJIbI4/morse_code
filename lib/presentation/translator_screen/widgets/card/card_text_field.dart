part of '../../translator_screen.dart';

class _CardTextField extends StatelessWidget {
  static const _prohibitedSymbols = ['…', '—', '-', '//'];

  final _CardType cardType;
  final TextEditingController textEditingController;
  final TranslatorResume resume;

  const _CardTextField({
    required this.cardType,
    required this.textEditingController,
    required this.resume,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 110),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: TextField(
          controller: textEditingController,
          cursorColor: ApplicationTheme.APPBAR_COLOR,
          maxLines: null,
          readOnly: cardType == _CardType.bottom,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            if (_prohibitedSymbols.contains(value)) {
              final formattedValue = replaceDotsAndDash(value)
                  .replaceAll('//', '/')
                  .replaceAll('./', '. / ')
                  .replaceAll('—/', '— / ');
              textEditingController.text = formattedValue;
            }
          },
          inputFormatters: resume == TranslatorResume.textToMorse
              ? [FilteringTextInputFormatter(
                  TextUtil.usualInputTextRegex,
                  allow: true, 
                  replacementString: '')
                ]
              : [FilteringTextInputFormatter(
                  TextUtil.morseInputTextRegex, 
                  allow: true),
                ],
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: cardType == _CardType.bottom
                ? InputBorder.none
                : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ApplicationTheme.ACTIVE_COLOR.withOpacity(0.3),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
