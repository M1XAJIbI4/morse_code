// Package imports:
import "package:flutter_tts/flutter_tts.dart";
import "package:injectable/injectable.dart";
import "package:just_audio/just_audio.dart";
import "package:rxdart/rxdart.dart";

// Project imports:
import "package:morse_code/domain/utils/translator_service.dart";
import "package:morse_code/gen/assets.gen.dart";

@Singleton()
class AudioService {
  static AudioPlayer? _listPlayer;
  static FlutterTts? _tts;

  static const dot = '.';
  static const dash = '-';
  static const spaceLetters = ' ';
  static const spaceWords = '/';

  bool _isRunningUsual = false;
  bool _isRunningMorse = false;

  final _morseSubject = BehaviorSubject<bool>();
  final _usualSubject = BehaviorSubject<bool>();
  
  AudioService() {
    _setMorseRunning(false);
    _setUsualRunning(false);
  }

  Future<void> play(String text, bool isMorseText) async {
    if (isMorseText && _isRunningMorse) {
      await _stopMorsePlayer();
      return;
    }

    if (isMorseText && _isRunningUsual) {
      await _stopUsualPlayer();
    }

    if (!isMorseText && _isRunningMorse) {
      await _stopMorsePlayer();
    }

    if (!isMorseText && _isRunningUsual) {
      await _stopUsualPlayer();
      return;
    }

    if (_isRunningUsual || _isRunningMorse) {
      return;
    }

    isMorseText ? await _playMorse(text) : await _playUsualText(text);
  }

  Future<void> stop() async {
    if (_isRunningUsual) {
      await _stopUsualPlayer();
    }

    if (_isRunningMorse) {
      await _stopMorsePlayer();
    }
  }

  Future<void> _playMorse(String message) async {
    if (_listPlayer != null) return;
    _listPlayer = AudioPlayer()..setShuffleModeEnabled(false);
    final audioSources = <AudioSource>[];
    final formattedMessage = TranslatorService.formatText(message).replaceAll(' / ', '/').split('');

    for (final char in formattedMessage) {
      final audioSource = switch (char) {
        dot => _dotSource(),
        dash => _dashSource(),
        spaceLetters => _voidSource(),
        spaceWords => _voidLongSource(),
        _ => null, 
      };
      if (audioSource != null) audioSources.add(audioSource);
    }

    final playlist = ConcatenatingAudioSource(children: audioSources);
    _setMorseRunning(true);
    await _listPlayer?.setAudioSource(
      playlist,
      initialIndex: 0,
      initialPosition: Duration.zero,
    );

    await _listPlayer?.play();
    await _listPlayer?.dispose();
    _listPlayer = null;
    _setMorseRunning(false);
  }

  Future<void> _playUsualText(String text) async {
    if (_tts != null) return;
    _setUsualRunning(true);
    _tts ??= FlutterTts()..setLanguage('En');

    _tts?.setCompletionHandler(() {
      _setUsualRunning(false);
      _tts?.stop();
      _tts = null;
    });

    await _tts?.speak(text);
  }

  Future<void> _stopUsualPlayer() async {
    await _tts?.stop();
    _tts = null;
    _setUsualRunning(false);
  }

  Future<void> _stopMorsePlayer() async {
    await _listPlayer?.dispose();
    _listPlayer = null;
    _setMorseRunning(false);
  }

  void _setUsualRunning(bool value) {
    _isRunningUsual = value;
    _usualSubject.add(value);
  }

  void _setMorseRunning(bool value) {
    _isRunningMorse = value;
    _morseSubject.add(value);
  }

  AudioSource _dotSource() => AudioSource.asset(Assets.sounds.dot);
  AudioSource _dashSource() => AudioSource.asset(Assets.sounds.dash);
  AudioSource _voidSource() => AudioSource.asset(Assets.sounds.voidShort);
  AudioSource _voidLongSource() => AudioSource.asset(Assets.sounds.voidLong);

  Stream<bool> get morseRunnigStream => _morseSubject.stream;
  Stream<bool> get usualRunnigStream => _usualSubject.stream;
}
