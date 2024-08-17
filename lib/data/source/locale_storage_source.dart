import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:morse_code/domain/models/morse_phrase.dart';
import 'package:rxdart/subjects.dart';

@LazySingleton()
class LocaleStorageSource {

  LocaleStorageSource() {
    _initWatch();
  }

  static const _favorites = 'favoritesBox';
  final _favoritesPhrasesSubject = BehaviorSubject<List<MorsePhrase>>();

  Box<MorsePhrase>? _favoritesBox;

  void _initWatch() async {
    _favoritesBox ??= await Hive.openBox<MorsePhrase>(_favorites);
    _favoritesBox?.watch().listen((event) async {
      if (event is MorsePhrase) {
        final phrases = await getFavoritesPhrases();
        _favoritesPhrasesSubject.add(phrases);
      }
    });
    final phrases = await getFavoritesPhrases();
    _favoritesPhrasesSubject.add(phrases);
  }

  Future<List<MorsePhrase>> getFavoritesPhrases() async {
    _favoritesBox ??= await Hive.openBox<MorsePhrase>(_favorites);
    return _favoritesBox!.values.toList();
  }

  Future<void> updateFavoritePhrase(String id, MorsePhrase phrase) async {
    _favoritesBox ??= await Hive.openBox<MorsePhrase>(_favorites);
    await _favoritesBox?.put(id, phrase);
  }

  Future<void> removeFavoritePhrase(String id) async {
    _favoritesBox ??= await Hive.openBox<MorsePhrase>(_favorites);
    await _favoritesBox?.delete(id);
  }

  Stream<List<MorsePhrase>> get favoritesPhrasesStream => _favoritesPhrasesSubject.stream;
}
