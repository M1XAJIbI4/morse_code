part of 'audio_cubit.dart';

sealed class AudioState {}

class AudioStateInit extends AudioState {}
class AudioStateProcessing extends AudioCubit {}
class AudioStateError extends AudioState {}