// Package imports:
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';

String get generateUuid => Uuid(goptions: GlobalOptions(CryptoRNG())).v4();
