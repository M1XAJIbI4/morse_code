import "package:flutter_tts/flutter_tts.dart";
import "package:just_audio/just_audio.dart";
import "package:morse_code/domain/utils/translator_service.dart";
import "package:morse_code/gen/assets.gen.dart";

//TODO: refactored
abstract final class AudioService {

  static AudioPlayer? _listPlayer;
  static FlutterTts? _tts;

  static const dot = '.';
  static const dash = '-';
  static const space = ' ';

  static bool _isRunningUsual = false;
  static bool _isRunnigMorse = false;

  static Future<void> play(String text, bool isMorseText) async {
    if (isMorseText && _isRunnigMorse) {
      await _stopMorsePlayer();
      return;
    }

    if (isMorseText && _isRunningUsual) {
      await _stopUsualPlayer();
      _isRunningUsual = false;
    }

    if (!isMorseText && _isRunnigMorse) {
      await _stopMorsePlayer();
    }

    if (!isMorseText && _isRunningUsual) {
      await _stopUsualPlayer();
      return;
    }

    if (_isRunningUsual || _isRunnigMorse) {
      return;
    }

    isMorseText ? await _playMorse(text) : await _playUsualText(text);
  }

  static Future<void> _playMorse(String message) async {
    if (_listPlayer != null) return;
    _listPlayer = AudioPlayer()..setShuffleModeEnabled(false);
    final audioSources = <AudioSource>[];
    final str =
        TranslatorService.formatText(message).replaceAll(' / ', ' ').split('');
    for (final char in str) {
      if (char == dot) {
        audioSources.add(_dotSource());
      } else if (char == dash) {
        audioSources.add(_dashSource());
      } else if (char == space) {
        audioSources.add(_voidSource());
      }
    }
    final playlist = ConcatenatingAudioSource(children: audioSources);

    _isRunnigMorse = true;
    await _listPlayer?.setAudioSource(
      playlist,
      initialIndex: 0,
      initialPosition: Duration.zero,
    );

    await _listPlayer?.play();
    await _listPlayer?.dispose();
    _listPlayer = null;
    _isRunnigMorse = false;
  }

  static Future<void> _playUsualText(String text) async {
    if (_tts != null) return;
    _isRunningUsual = true;
    _tts ??= FlutterTts()..setLanguage('En');

    _tts?.setCompletionHandler(() {
      _isRunningUsual = false;
      _tts?.stop();
      _tts = null;
    });

    await _tts?.speak(text);
  }

  static Future<void> _stopUsualPlayer() async {
    await _tts?.stop();
    _tts = null;
    _isRunningUsual = false;
  }

  static Future<void> _stopMorsePlayer() async {
    await _listPlayer?.dispose();
    _listPlayer = null;
    _isRunnigMorse = false;
  }

  static AudioSource _dotSource() => AudioSource.asset(Assets.sounds.dot);
  static AudioSource _dashSource() => AudioSource.asset(Assets.sounds.dash);
  static AudioSource _voidSource() =>
      AudioSource.asset(Assets.sounds.voidSpace);
}
