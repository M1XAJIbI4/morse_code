import 'package:flutter/material.dart';
import 'package:morse_code/data/source/locale_storage_source.dart';
import 'package:morse_code/dependencies/inherited_dependencies.dart';
import 'package:morse_code/domain/repository/favorites_repository.dart';
import 'package:morse_code/domain/utils/audio_service.dart';

abstract interface class Dependencies {
  factory Dependencies.of(BuildContext context) => InheritedDependencies.of(context);

  abstract final LocaleStorageSource localeStorageSource;

  abstract final FavoritesRepository favoritesRepository;

  abstract final AudioService audioService;
}

final class MutableDependencies implements Dependencies {

  MutableDependencies(): initContext = <String, Object?>{};

  /// Initialization context
  final Map<Object?, Object?> initContext;

  @override
  late FavoritesRepository favoritesRepository;

  @override
  late LocaleStorageSource localeStorageSource;

  @override
  late AudioService audioService;

  ImmutableDependencies freeze() => ImmutableDependencies(
    favoritesRepository: favoritesRepository, 
    localeStorageSource: localeStorageSource, 
    audioService: audioService,
  );
}


final class ImmutableDependencies implements Dependencies {

  ImmutableDependencies({
    required this.favoritesRepository,
    required this.localeStorageSource,
    required this.audioService,
  });

  @override
  final FavoritesRepository favoritesRepository;

  @override
  final LocaleStorageSource localeStorageSource;

  @override
  final AudioService audioService;
}