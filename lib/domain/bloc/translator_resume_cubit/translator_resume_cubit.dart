// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:morse_code/domain/models/translator_resume.dart';

@injectable
class TranslatorResumeCubit extends Cubit<TranslatorResume> {
  TranslatorResumeCubit(): super(TranslatorResume.textToMorse);

  Future<void> changeResume() async {
    final newResume = state == TranslatorResume.textToMorse 
        ? TranslatorResume.morseToText 
        : TranslatorResume.textToMorse;
    emit(newResume);
  }

  TranslatorResume get currentResume => state;
}
