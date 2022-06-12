import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class SetFirstTimeOpenToFalse {
  final PreferencesService _preferencesService;

  SetFirstTimeOpenToFalse(this._preferencesService);

  Future<void> call() => _preferencesService.setFirstTimeOpenToFalse();
}
