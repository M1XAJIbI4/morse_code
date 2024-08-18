import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:morse_code/domain/models/morse_phrase.dart';
import 'package:morse_code/domain/repository/favorites_repository.dart';

part 'favorites_phrases_state.dart';

@injectable
class FavoritesPhrasesCubit extends Cubit<FavoritesPhrasesState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesPhrasesCubit(this._favoritesRepository)
      : super(FavoritesPhrasesStateLoading()) {
    _initialize();
  }

  StreamSubscription<List<MorsePhrase>>? _streamSubscription;

  void _initialize() {
    _streamSubscription =
        _favoritesRepository.favoritesPhrasesStream.listen((phrases) {
      phrases.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      emit(FavoritesPhrasesStateReady(morsePhrases: [...phrases]));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
