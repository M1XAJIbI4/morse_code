// ignore_for_file: constant_identifier_names

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:morse_code/gen/fonts.gen.dart';
import 'package:morse_code/presentation/start_screen/start_screen.dart';

// import 'package:morse_code/presentation/start_screen/start_screen.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morse code translator',
      supportedLocales: const [
        Locale('en', 'EN'),
      ],
      theme: ApplicationTheme.lightTheme,
      home: const StartScreen(),
    );
  }
}

class ApplicationTheme {

  static const APPBAR_COLOR = Color(0xFF009E89);
  static const CANVAS_COLOR = Color(0xFFFFFBFE);
  static const SHADOW_COLOR = Color(0xFF11DABF);
  static const CARD_COLOR = Color(0xFF6750A4);
  static const ACTIVE_COLOR = Color(0xFF003366);
  static const BORDER_COLOR = Color(0xFFC4C4C4);

  static final lightTheme = ThemeData(
    cardColor: CARD_COLOR.withOpacity(0.05),
    canvasColor: CANVAS_COLOR,
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      backgroundColor: APPBAR_COLOR,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
        height: 21.09 / 18.0,
      )
    ),
  );
}
