// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:morse_code/data/source/locale_storage_source.dart';
import 'package:morse_code/domain/models/morse_phrase.dart';
import 'package:morse_code/domain/repository/favorites_repository.dart';

@LazySingleton(as: FavoritesRepository)
class FavoritesRepositoryImpl implements FavoritesRepository {
  final LocaleStorageSource _localeStorageSource;

  FavoritesRepositoryImpl(this._localeStorageSource);

  @override
  Future<void> addFavoritesPhrase(MorsePhrase phrase) async {
    await _localeStorageSource.updateFavoritePhrase(phrase.id, phrase);
  }

  @override
  Stream<List<MorsePhrase>> get favoritesPhrasesStream =>
      _localeStorageSource.favoritesPhrasesStream;

  @override
  Future<void> removeFavoritesPhrase(String id) async {
    await _localeStorageSource.removeFavoritePhrase(id);
  }
  
  @override
  Future<List<MorsePhrase>> getSavedPhrases() {
    return _localeStorageSource.getFavoritesPhrases();
  }
}
