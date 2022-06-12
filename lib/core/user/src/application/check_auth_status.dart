import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class CheckAuthStatus {
  final AuthService _authService;

  CheckAuthStatus(this._authService);

  Stream<Option<UserEntity>> call() => _authService.getUser();
}
