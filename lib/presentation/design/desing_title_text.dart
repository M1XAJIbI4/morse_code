import 'package:flutter/material.dart';
import 'package:morse_code/gen/fonts.gen.dart';
import 'package:morse_code/presentation/application/application.dart';

class DesignTitleText extends StatelessWidget {
  final String text;
  final Color color;

  const DesignTitleText({
    required this.text,
    this.color = ApplicationTheme.ACTIVE_COLOR,
    super.key,
  });
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 19.0,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
          fontFamily: FontFamily.roboto,
          height: 18.75 / 16,
          color: ApplicationTheme.ACTIVE_COLOR,
        ),
      ),
    );
  }
}