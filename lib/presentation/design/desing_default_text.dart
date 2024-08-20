// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:morse_code/gen/fonts.gen.dart';

class DesignDefaultText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double height;

  const DesignDefaultText({
    required this.text,
    this.fontSize = 14,
    this.height = 16.41 / 14,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        fontFamily: FontFamily.roboto,
        height: height,
        color: Colors.black,
      ),
    );
  }
}
