import "package:just_audio/just_audio.dart";
import "package:morse_code/gen/assets.gen.dart";

abstract final class AudioService {
  static final _listPlayer = AudioPlayer()..setShuffleModeEnabled(false);
  // static final _dotPlayer = AudioPlayer();
  // static final _dashPlayer = AudioPlayer();

  static const dot = '.';
  static const dash = '-';

  static Future<void> playMorse(String message) async {
    final audioSources = <AudioSource>[];
    for (final char in message.split('')) {
      if (char == dot) {
        audioSources.add(_dotSource());

      } else if (char == dash) {
        audioSources.add(_dashSource());
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


  // static Future<void> _playDot() async {
  //   await _dotPlayer.setAudioSource(
  //     _dotSource()
  //   );
  //   await _dotPlayer.play();
  // }

  // static Future<void> _playDash() async {
  //   await _dashPlayer.setAudioSource(
  //     _dashSource()
  //   );
  //   await _dashPlayer.play();
  // }

  static AudioSource _dotSource() => AudioSource.asset(Assets.sounds.dot);
  
  static AudioSource _dashSource() => AudioSource.asset(Assets.sounds.dash);
}
