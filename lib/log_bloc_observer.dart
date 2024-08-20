// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'logger.dart';

class LogBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logger.d('onCreate -- cubit: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.d({
      'onChange -- cubit': bloc.runtimeType.toString(),
      'currentState': change.currentState.toString(),
      'nextState': change.nextState.toString(),
    });
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e(
      '''
      {
        'onError -- cubit': bloc.runtimeType.toString(),
        'error': error.toString(),
      },
      ''',
      time: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logger.d('onClose -- cubit: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.d({
      'onEvent -- bloc': bloc.runtimeType.toString(),
      'event': event.toString(),
    });
  }
}
