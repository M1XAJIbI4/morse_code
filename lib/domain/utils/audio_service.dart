import "package:just_audio/just_audio.dart";
import "package:morse_code/domain/utils/translator_service.dart";
import "package:morse_code/gen/assets.gen.dart";

abstract final class AudioService {
  static final _listPlayer = AudioPlayer()..setShuffleModeEnabled(false);

  static const dot = '.';
  static const dash = '-';
  static const space = ' ';

  static Future<void> playMorse(String message) async {
    final audioSources = <AudioSource>[];
    final str = TranslatorService.formatText(message).replaceAll(' / ', ' ').split('');
    for (final char in str) {
      if (char == dot) {
        audioSources.add(_dotSource());

      } else if (char == dash) {
        audioSources.add(_dashSource());

      } else if (char == space) {
        audioSources.add(_voidSource());
      }
    }
    final playlist = ConcatenatingAudioSource(
      children: audioSources
    );

    await _listPlayer.setAudioSource(
      playlist,
      initialIndex: 0,
      initialPosition: Duration.zero,
    );
    await _listPlayer.play();
  }

  static AudioSource _dotSource() => AudioSource.asset(Assets.sounds.dot);
  
  static AudioSource _dashSource() => AudioSource.asset(Assets.sounds.dash);

  static AudioSource _voidSource() => AudioSource.asset(Assets.sounds.voidSpace);

  // static Future<void> play;
}
