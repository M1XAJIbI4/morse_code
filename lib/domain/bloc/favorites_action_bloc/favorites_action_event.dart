part of 'favorites_action_bloc.dart';

sealed class FavoritesActionEvent {}

class FavoritesActionAddPhraseEvent extends FavoritesActionEvent {
  final String originalText;
  final String morseText;
  final SupLocale locale;

  FavoritesActionAddPhraseEvent({
    required this.originalText, 
    required this.morseText,
    this.locale = SupLocale.enEN,
  });
}

class FavoritesActionRemovePhraseEvent extends FavoritesActionEvent {
  final String phraseId;

  FavoritesActionRemovePhraseEvent(this.phraseId);
}
