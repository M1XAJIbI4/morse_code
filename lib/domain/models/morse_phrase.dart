import 'package:hive/hive.dart';
import 'package:morse_code/domain/models/sup_locale.dart';

part 'morse_phrase.g.dart';

@HiveType(typeId: 0)
class MorsePhrase {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String originalText;

  @HiveField(2)
  final String morseText;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final SupLocale locale; 

  MorsePhrase({
    required this.id, 
    required this.originalText, 
    required this.morseText,
    required this.createdAt,
    this.locale = SupLocale.enEN,
  });
}