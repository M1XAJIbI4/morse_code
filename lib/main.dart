// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morse_code/dependencies/inherited_dependencies.dart';
import 'package:morse_code/dependencies/initialization.dart';

// Project imports:
import 'package:morse_code/logger.dart';
import 'package:morse_code/presentation/application/application.dart';
import 'package:morse_code/presentation/initialization_splash_screen/initialization_splash_screen.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _setPreferredOrientation();

    final initializationProgress =
        ValueNotifier<({int progress, String message})>(
            (progress: 0, message: ''));
    runApp(InitializationSplashScreen(progress: initializationProgress));

    initializeApp(
      onProgress: (percent, message) => initializationProgress.value = (message: message, progress: percent),
      onSuccess: (dependencies) {
        initializationProgress.dispose();
        runApp(InheritedDependencies(
          dependencies: dependencies,
          appWidget: const Application(),
        ));
      },
      onError: (_, ___) => runApp(
        const ColoredBox(color: Colors.red),
      ),
    );
  }, (err, stacktrace) {
    logger.e(err);
  });
}

Future<void> _setPreferredOrientation() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  return SystemChrome.setPreferredOrientations(_getPortraitOrientations());
}

List<DeviceOrientation> _getPortraitOrientations() {
  return [
    DeviceOrientation.portraitUp,
  ];
}
