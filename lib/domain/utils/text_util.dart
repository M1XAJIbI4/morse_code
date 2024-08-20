abstract class TextUtil {
  
  static final spaceRegex = RegExp(r"\s+");
  static final usualInputTextRegex = RegExp('[?!,.@"\'&()\$:;+_a-z A-Z 0-9]');
  static final morseInputTextRegex = RegExp('[.…—ы-\\s\\/]');
}

