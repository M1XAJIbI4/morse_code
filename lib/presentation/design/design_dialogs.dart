// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:morse_code/presentation/application/application.dart';
import 'package:morse_code/presentation/design/desing_title_text.dart';

abstract class DesignDialogs {
  static void showSnackbar(BuildContext context, {
    required String text,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ApplicationTheme.APPBAR_COLOR,
      content: Center(
        child: DesignTitleText(
          text: text,
          color: Colors.white,
        ),
      ),
    ));
  }
}
