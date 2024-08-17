part of 'translator_bloc.dart';

sealed class TranslatorEvent {}

class TranslatorTranslateEvent extends TranslatorEvent {
  final String? originalText;
  final String? morseText;
  final TranslatorResume resume;

  TranslatorTranslateEvent({
    required this.originalText,
    required this.morseText, 
    required this.resume,
  });
}

class TranslatorInitializeEvent extends TranslatorEvent {
  final String originalText;
  final String morseText;

  TranslatorInitializeEvent({
    required this.originalText, 
    required this.morseText,
  });
}
