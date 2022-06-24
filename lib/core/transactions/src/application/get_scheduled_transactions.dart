import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class GetScheduledTransactions {
  final TransactionRepository _transactionRepository;
  final GetProfileInfo _getProfileInfo;

  const GetScheduledTransactions(
    this._transactionRepository,
    this._getProfileInfo,
  );

  Stream<Option<List<Transaction>>> call({
    required bool isFirstTimeOpen,
  }) async* {
    yield* _getProfileInfo().switchMap((user) {
      return user.fold(
        () => Stream.value(None()),
        (user) => _transactionRepository.fetchTransactions(
          TransactionUserId(user.id.value),
          isFirstTimeOpen: isFirstTimeOpen,
        ),
      );
    });
  }
}
