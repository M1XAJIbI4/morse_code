import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:morse_code/domain/utils/audio_service.dart';
import 'package:rxdart/rxdart.dart';

part 'audio_state.dart';

@injectable
class AudioCubit extends Cubit<AudioState> {
  final AudioService _audioService;

  AudioCubit(this._audioService): super(AudioState(
    isPlayingMorseText: false,
    isPlayingUsualText: false,
  )) {
    _initialize();
  }

  StreamSubscription? _streamSubscription;

  Future<void> _initialize() async {
    final stateStream = Rx.combineLatest2(
      _audioService.usualRunnigStream, 
      _audioService.morseRunnigStream, 
      (usual, morse) {        
        return AudioState(
        isPlayingMorseText: morse, 
        isPlayingUsualText: usual,
      );
      }
    );

    _streamSubscription = stateStream.listen((state) => emit(state));
  }

  Future<void> play({
    required String text,
    required bool isMorseText
  }) async {

    try {
      await _audioService.play(text, isMorseText);
    } catch (_) {}
  }

  Future<void> stop() async {
    try {
      await _audioService.stop();
    } catch (_) {}
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}