import 'package:flutter/material.dart';
import 'package:morse_code/presentation/design/desing_title_text.dart';

class MorseText extends StatelessWidget {
  final Color color;

  const MorseText({
    this.color = Colors.black,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DesignTitleText(
      text: 'Morse',
      color: color,
    );
  }
}