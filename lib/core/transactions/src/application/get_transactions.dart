import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class GetTransactions {
  final TransactionRepository _transactionRepository;
  final GetProfileInfo _getProfileInfo;

  const GetTransactions(
    this._transactionRepository,
    this._getProfileInfo,
  );

  Stream<Option<List<Transaction>>> call() async* {
    yield* _getProfileInfo().switchMap((user) {
      return user.fold(
        () => Stream.value(None()),
        (user) => _transactionRepository
            .fetchTransactions(TransactionUserId(user.id.value)),
      );
    });
  }
}
