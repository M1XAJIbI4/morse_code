part of 'translator_bloc.dart';

sealed class TranslatorEvent {}

class TranslatorTranslateEvent extends TranslatorEvent {
  final String text;
  final TranslatorResume resume;

  TranslatorTranslateEvent({
    required this.text,
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

class TranslatorClearEvent extends TranslatorEvent {}
