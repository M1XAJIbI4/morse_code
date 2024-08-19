import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:morse_code/domain/models/morse_phrase.dart';
import 'package:morse_code/domain/models/sup_locale.dart';
import 'package:morse_code/injection.config.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final hiveDirectory = await getApplicationSupportDirectory();
  Hive.init(hiveDirectory.path);
  Hive.registerAdapter(MorsePhraseAdapter());
  Hive.registerAdapter(SupLocaleAdapter());
  getIt.init();
}
