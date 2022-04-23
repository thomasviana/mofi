// ignore: depend_on_referenced_packages
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependency_injection.config.dart';

enum Environment { prod, uat, dev }

final GetIt sl = GetIt.instance;

@injectableInit
Future<void> configureInjection(Environment env) async {
  $initGetIt(sl, environment: env.toString());
}
