part of '../../translator_screen.dart';

class _CardTextField extends StatelessWidget {
  final _CardType cardType;
  final TextEditingController textEditingController;

  const _CardTextField({
    required this.cardType,
    required this.textEditingController,
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
