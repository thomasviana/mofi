import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class GetAccounts {
  final AccountRepository _accountRepository;
  final GetProfileInfo _getProfileInfo;

  const GetAccounts(
    this._accountRepository,
    this._getProfileInfo,
  );

  Stream<Option<List<Account>>> call() async* {
    yield* _getProfileInfo().switchMap((user) {
      if (user != null) {
        return _accountRepository.fetchAccounts(AccountUserId(user.id.value));
      } else {
        return Stream.value(None());
      }
    });
  }
}
