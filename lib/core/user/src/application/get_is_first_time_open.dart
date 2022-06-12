import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class GetIsFirstTimeOpen {
  final PreferencesService _preferencesService;

  GetIsFirstTimeOpen(this._preferencesService);

  Stream<bool> call() => _preferencesService.firstTimeOpen;
}
