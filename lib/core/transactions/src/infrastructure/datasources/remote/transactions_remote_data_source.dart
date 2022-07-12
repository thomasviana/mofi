import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mofi/core/transactions/domain.dart';
import 'package:mofi/core/transactions/infrastructure.dart';

abstract class TransactionsRemoteDataSource {
  Future<void> addOrUpdateTransaction(Transaction transaction);
  Future<void> addOrUpdateTransactions(List<Transaction> transactions);
  Stream<Option<List<Transaction>>> getAllTransactions();
  Future<void> deleteTransaction(TransactionId transactionId);
  Future<void> deleteAllTransactions();

  // Scheduled Transactions

  Future<void> addOrUpdateScheduledTransaction(
    ScheduledTransaction scheduledTransaction,
  );
  Future<void> addOrUpdateScheduledTransactions(
    List<ScheduledTransaction> transactions,
  );
  Stream<Option<List<ScheduledTransaction>>> getAllScheduledTransactions();
  Future<void> deleteScheduledTransaction(TransactionId transactionId);
  Future<void> deleteAllScheduledTransactions();
}

@LazySingleton(as: TransactionsRemoteDataSource)
class TransactionsRemoteDataSourceImpl implements TransactionsRemoteDataSource {
  final TransactionsFirebaseProvider _transactionsFirebaseProvider;

  TransactionsRemoteDataSourceImpl(
    this._transactionsFirebaseProvider,
  );

  @override
  Future<void> addOrUpdateTransaction(Transaction transaction) =>
      _transactionsFirebaseProvider.addOrUpdateTransaction(transaction);

  @override
  Future<void> addOrUpdateTransactions(List<Transaction> transactions) async {
    for (final transaction in transactions) {
      await _transactionsFirebaseProvider.addOrUpdateTransaction(transaction);
    }
  }

  @override
  Stream<Option<List<Transaction>>> getAllTransactions() =>
      _transactionsFirebaseProvider.getTransactions();

  @override
  Future<void> deleteTransaction(TransactionId transactionId) =>
      _transactionsFirebaseProvider.deleteTransaction(transactionId);

  @override
  Future<void> deleteAllTransactions() =>
      _transactionsFirebaseProvider.deleteAllTransactions();

  // Scheduled Transactions

  @override
  Future<void> addOrUpdateScheduledTransaction(
    ScheduledTransaction scheduledTransaction,
  ) =>
      _transactionsFirebaseProvider
          .addOrUpdateScheduledTransaction(scheduledTransaction);

  @override
  Future<void> addOrUpdateScheduledTransactions(
    List<ScheduledTransaction> scheduledTransactions,
  ) async {
    for (final scheduledTransaction in scheduledTransactions) {
      await _transactionsFirebaseProvider
          .addOrUpdateScheduledTransaction(scheduledTransaction);
    }
  }

  @override
  Stream<Option<List<ScheduledTransaction>>> getAllScheduledTransactions() =>
      _transactionsFirebaseProvider.getScheduledTransactions();

  @override
  Future<void> deleteScheduledTransaction(TransactionId transactionId) =>
      _transactionsFirebaseProvider.deleteScheduledTransaction(transactionId);

  @override
  Future<void> deleteAllScheduledTransactions() =>
      _transactionsFirebaseProvider.deleteAllScheduledTransactions();
}
