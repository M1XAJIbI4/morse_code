part of 'translator_bloc.dart';

sealed class TranslatorState {}

class TranslatorStateInit extends TranslatorState {}

class TranslatorStateLoading extends TranslatorState {}

class TranslatorStateReady extends TranslatorState {
  final String originalText;
  final String morseText;

  TranslatorStateReady({
    required this.originalText, 
    required this.morseText,
  });
}

class TranslatorStateError extends TranslatorState {
  final String errMessage;

  TranslatorStateError({required this.errMessage});
}