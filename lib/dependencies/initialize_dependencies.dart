import 'dart:async';

import 'package:hive/hive.dart';
import 'package:morse_code/data/repositories/favorites_repository_impl.dart';
import 'package:morse_code/data/source/locale_storage_source.dart';
import 'package:morse_code/dependencies/dependencies.dart';
import 'package:morse_code/domain/models/morse_phrase.dart';
import 'package:morse_code/domain/models/sup_locale.dart';
import 'package:morse_code/domain/utils/audio_service.dart';
import 'package:morse_code/logger.dart';
import 'package:path_provider/path_provider.dart';

Future<Dependencies> initializeDependencies({
  void Function(int progress, String message)? onProgress,
}) async {
  final dependencies = MutableDependencies();
  final totalSteps = _initializationSteps.length;

  var currentStep = 0;
  for (final step in _initializationSteps.entries) {
    currentStep++;
    final percent = (currentStep * 100 ~/ totalSteps).clamp(0, 100);
    onProgress?.call(percent, step.key);
    logger.d('Initialization step $currentStep ${step.key}');
    await step.value(dependencies);
  }
  final result = dependencies.freeze();
  return result;
}

typedef _InitializationStep = FutureOr<void> Function(
    MutableDependencies dependencies);

final Map<String, _InitializationStep> _initializationSteps = {

    'Initializing database': (dep) async {
      final hiveDirectory = await getApplicationSupportDirectory();
      Hive.init(hiveDirectory.path);
      Hive.registerAdapter(MorsePhraseAdapter());
      Hive.registerAdapter(SupLocaleAdapter());

      dep.localeStorageSource = LocaleStorageSource();
    },    

    'Initializing repositories': (dep) => dep.favoritesRepository = FavoritesRepositoryImpl(
        dep.localeStorageSource,
      ),

    'Initalizing audio service': (dependencies) => dependencies.audioService = AudioService()
};