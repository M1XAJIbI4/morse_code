import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:morse_code/domain/utils/audio_service.dart';

part 'audio_state.dart';

@injectable
class AudioCubit extends Cubit<AudioState> {
  AudioCubit(): super(AudioStateInit());


  Future<void> play({
    required String text,
    required bool isMorseText
  }) async {
    if (text.isEmpty || state is AudioStateProcessing) {
      return;
    }

    try {
      await AudioService.play(text, isMorseText);
    } catch (_) {
      emit(AudioStateError());
    } finally {
      emit(AudioStateInit());
    }
  }
}