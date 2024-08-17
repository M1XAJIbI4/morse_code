import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:morse_code/domain/models/translator_resume.dart';
import 'package:morse_code/domain/utils/translator_service.dart';

part 'translator_event.dart';
part 'translator_state.dart';

@injectable
class TranslatorBloc extends Bloc<TranslatorEvent, TranslatorState> {
  final _translator = TranslatorService();

  TranslatorBloc() : super(TranslatorStateInit()) {
    on<TranslatorEvent>(_onEvent);
  }

  String _currentOriginal = '';
  String _currentMorse = '';

  Future<void> _onEvent(
      TranslatorEvent mainEvent, Emitter<TranslatorState> emit) async {
    switch (mainEvent) {
      case TranslatorTranslateEvent event: await _onTranslate(event, emit);
      case TranslatorInitializeEvent event: await _onInitialize(event, emit);
    }
  }

  Future<void> _onInitialize(
    TranslatorInitializeEvent event,
    Emitter<TranslatorState> emit
  ) async {
    _currentMorse = event.morseText;
    _currentOriginal = event.originalText;
    await _emitReady(emit);
  }

  Future<void> _onTranslate(
    TranslatorTranslateEvent event,
    Emitter<TranslatorState> emit,
  ) async {
    try {
      final (resume, eventOriginal, eventMorse) = (
        event.resume,
        event.originalText,
        event.morseText,
      );

      print('FOOBAR 1 -$resume $eventOriginal $eventMorse');
      if (eventOriginal == _currentOriginal ||
          eventMorse == _currentMorse) {
        return;
      }

      print('FOOBAR 2');

      emit(TranslatorStateLoading());
      final (newOriginal, newMorse) = switch (resume) {
        TranslatorResume.textToMorse => (eventOriginal, _textToMorse(eventOriginal)),
        TranslatorResume.morseToText => (_morseToText(eventMorse), eventMorse),
      };

      if (newOriginal == null || newMorse == null) {
        throw Exception();
      }

      _currentMorse = newMorse;
      _currentOriginal = newOriginal;
      print('FOOBAR 3 - $_currentMorse $_currentOriginal');
      await _emitReady(emit);
    } catch (_) {
      emit(TranslatorStateError(errMessage: 'errMessage'));
      await Future.delayed(const Duration(milliseconds: 200));
      await _emitReady(emit);
    }
  }

  Future<void> _emitReady(Emitter<TranslatorState> emit) async {
    emit(TranslatorStateReady(
      originalText: _currentOriginal,
      morseText: _currentMorse,
    ));
  }

  String? _textToMorse(String? text) {
    String? result;
    if (text != null) {
      result = _translator.textToMorse(text);
    }
    return result;
  }

  String? _morseToText(String? morse) {
    String? result;
    if (morse != null) {
      result = _translator.morseToText(morse);
    }
    return result;
  }

  String get currentOriginal => _currentOriginal;
  String get currentMorse => _currentMorse;
}
