import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:morse_code/domain/models/morse_phrase.dart';
import 'package:morse_code/domain/models/sup_locale.dart';
import 'package:morse_code/domain/repository/favorites_repository.dart';
import 'package:morse_code/domain/utils/uuid_generator.dart';

part 'favorites_action_event.dart';
part 'favorites_action_state.dart';

@injectable
class FavoritesActionBloc extends Bloc<FavoritesActionEvent, FavoritesActionState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesActionBloc(this._favoritesRepository): super(FavoritesActionStateInit()) {
    on<FavoritesActionEvent>(_onEvent);
  }
  

  Future<void> _onEvent(
    FavoritesActionEvent mainEvent, 
    Emitter<FavoritesActionState> emit,
  ) async {
    switch (mainEvent) {
      case FavoritesActionAddPhraseEvent event: _onAddPhraseEvent(event, emit);
      case FavoritesActionRemovePhraseEvent event: _onRemoveEvent(event, emit);
    }
  }

  Future<void> _onAddPhraseEvent(
    FavoritesActionAddPhraseEvent event,
    Emitter<FavoritesActionState> emit
  ) async {
    try {
      final newPhrase = MorsePhrase(
        id: generateUuid, 
        originalText: event.originalText, 
        morseText: event.morseText,
        createdAt: DateTime.now(),
      );
      await _favoritesRepository.addFavoritesPhrase(newPhrase);
    } catch (_) {
      emit(FavoritesAcionStateError('Error adding to favorites'));
    } finally {
      emit(FavoritesActionStateInit());
    }
  } 

  Future<void> _onRemoveEvent(
    FavoritesActionRemovePhraseEvent event,
    Emitter<FavoritesActionState> emit
  ) async {
    try {
      await _favoritesRepository.removeFavoritesPhrase(event.phraseId);
    } catch (_) {
      emit(FavoritesAcionStateError('Error removing from favorites'));
    } finally {
      emit(FavoritesActionStateInit());
    }
  }
}