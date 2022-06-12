import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class GetProfileInfo {
  final AuthService _authService;
  GetProfileInfo(this._authService);

  Stream<Option<UserEntity>> call() => _authService.getUser();
}
