import 'package:hive/hive.dart';

part 'morse_phrase.g.dart';

@HiveType(typeId: 0)
class MorsePhrase {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String originalText;

  @HiveField(2)
  final String morseText;

  MorsePhrase({
    required this.id, 
    required this.originalText, 
    required this.morseText,
  });
}