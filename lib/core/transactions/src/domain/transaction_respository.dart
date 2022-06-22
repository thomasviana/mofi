import 'package:dartz/dartz.dart';

import '../../domain.dart';

abstract class TransactionRepository {
  Stream<Option<List<Transaction>>> fetchTransactions(
    TransactionUserId userId, {
    required bool isFirstTimeOpen,
  });

  Future<void> save(Transaction transaction);

  Future<void> delete(TransactionId txId);

  Future<void> deleteAll();

  Future<void> backUp(TransactionUserId userId);
}
