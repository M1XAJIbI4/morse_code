part of 'favorites_action_bloc.dart';

sealed class FavoritesActionState {}

class FavoritesActionStateInit extends FavoritesActionState {}

class FavoritesActionStateLoading extends FavoritesActionState {
  final List<String> updateingPhrasesIds;
  FavoritesActionStateLoading(this.updateingPhrasesIds);
}

class FavoritesAcionStateError extends FavoritesActionState {
  final String errMessage;
  FavoritesAcionStateError(this.errMessage);
}