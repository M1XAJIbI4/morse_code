
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InitializationSplashScreen extends StatefulWidget {
  final ValueListenable<({int progress, String message})> progress;

  const InitializationSplashScreen({
    super.key,
    required this.progress,
  });


  @override
  State<InitializationSplashScreen> createState() => _InitializationSplashScreenState();
}

class _InitializationSplashScreenState extends State<InitializationSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColoredBox(
        color: Theme.of(context).canvasColor,
        child: Center(
          child: ValueListenableBuilder<({int progress, String message})>(
            valueListenable: widget.progress, 
            builder: (_, value, __) => Text(
                '${value.message} - ${value.progress}',
              ),
          ),
        ),
      ),
    );
  }
}