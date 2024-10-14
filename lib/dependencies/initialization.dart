import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:morse_code/dependencies/dependencies.dart';
import 'package:morse_code/dependencies/initialize_dependencies.dart';
import 'package:morse_code/logger.dart';

Future<Dependencies>? _initializeApp;

Future<Dependencies> initializeApp({
  void Function(int progress, String message)? onProgress,
  FutureOr<void> Function(Dependencies dependencies)? onSuccess,
  void Function(Object error, StackTrace stackTrace)? onError,
}) =>
    _initializeApp ??= Future<Dependencies>(() async {
      late final WidgetsBinding binding;
      final stopwatch = Stopwatch()..start();
      try {
        binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();
        await _catchExceptions();
        final dependencies =
            await initializeDependencies(onProgress: onProgress)
                .timeout(const Duration(minutes: 5));
        await onSuccess?.call(dependencies);
        return dependencies;
      } catch (error, stackTrace) {
        onError?.call(error, stackTrace);
        logger.e(error, stackTrace: stackTrace);
        rethrow;
      } finally {
        stopwatch.stop();
        binding.addPostFrameCallback((_) {
          // Closes splash screen, and show the app layout.
          binding.allowFirstFrame();
          //final context = binding.renderViewElement;
        });
        _initializeApp = null;
      }
    });

Future<void> _catchExceptions() async {
  try {
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      logger.e(error, stackTrace: stackTrace);
      return true;
    };

    final sourceFlutterError = FlutterError.onError;
    FlutterError.onError = (final flutterErrorDetails) {
      logger.e(
        flutterErrorDetails.exception,
        stackTrace: flutterErrorDetails.stack,
      );
      sourceFlutterError?.call(flutterErrorDetails);
    };
  } on Object catch (error, stackTrace) {
    logger.e(
      error,
      stackTrace: stackTrace,
    );
  }
}
