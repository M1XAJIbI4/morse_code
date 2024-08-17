part of 'favorites_phrases_cubit.dart';

sealed class FavoritesPhrasesState {}

class FavoritesPhrasesStateLoading extends FavoritesPhrasesState {}

class FavoritesPhrasesStateReady extends FavoritesPhrasesState {
  final List<MorsePhrase> morsePhrases;

  FavoritesPhrasesStateReady({required this.morsePhrases});
}
