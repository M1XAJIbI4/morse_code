// Project imports:
import 'package:morse_code/domain/models/morse_phrase.dart';

abstract interface class FavoritesRepository {
  Stream<List<MorsePhrase>> get favoritesPhrasesStream;

  Future<void> addFavoritesPhrase(MorsePhrase phrase);

  Future<void> removeFavoritesPhrase(String id);

  Future<List<MorsePhrase>> getSavedPhrases();
}
