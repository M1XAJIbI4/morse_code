// Package imports:
import 'package:hive/hive.dart';

part 'sup_locale.g.dart';

@HiveType(typeId: 1)
enum SupLocale {
  @HiveField(0)
  enEN,
}

extension SupLocaleExtension on SupLocale {
  String get title => switch (this) {
    SupLocale.enEN => 'English'
  };
}
