import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morse_code/injection.dart';
import 'package:morse_code/logger.dart';
import 'package:morse_code/presentation/application/application.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _setPreferredOrientation();
    await configureDependencies();    
    runApp(const Application());

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
