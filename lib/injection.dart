import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:morse_code/injection.config.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  getIt.init();
}
