import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';
import '../../infrastructure.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionsLocalDataSource _transactionsLocalDataSource;
  final TransactionsRemoteDataSource _transactionsRemoteDataSource;

  TransactionRepositoryImpl(
    this._transactionsLocalDataSource,
    this._transactionsRemoteDataSource,
  );

  bool _isFirstTimeOpen = true;

  @override
  Stream<Option<List<Transaction>>> fetchTransactions(
    TransactionUserId userId, {
    required bool isFirstTimeOpen,
  }) async* {
    if (_isFirstTimeOpen) _getRemoteTransactions(userId);
    yield* _transactionsLocalDataSource.getCachedTransactions(userId).asyncMap(
          (optionCachedTransactions) => optionCachedTransactions.fold(
            () => Future.value(None()),
            (cachedTransactions) => Future.value(optionOf(cachedTransactions)),
          ),
        );
  }

  Future<void> _getRemoteTransactions(TransactionUserId userId) =>
      _transactionsRemoteDataSource.getAllTransactions().first.then(
            (optionRemoteTransactions) => optionRemoteTransactions.fold(
              () {},
              (remoteTransactions) async {
                await _transactionsLocalDataSource
                    .cacheTransactions(remoteTransactions);
                _isFirstTimeOpen = false;
              },
            ),
          );

  @override
  Future<void> save(Transaction transaction) async {
    await _transactionsLocalDataSource.cacheTransaction(transaction);
    await _transactionsRemoteDataSource.addOrUpdateTransaction(transaction);
  }

  @override
  Future<void> delete(TransactionId transactionId) async {
    await _transactionsLocalDataSource.deleteTransaction(transactionId);
    await _transactionsRemoteDataSource.deleteTransaction(transactionId);
  }

  @override
  Future<void> deleteAll() async {
    await _transactionsLocalDataSource.deleteAllTransactions();
    await _transactionsRemoteDataSource.deleteAllTransactions();
  }

  @override
  Future<void> backUp(TransactionUserId userId) async {
    _transactionsLocalDataSource.getCachedTransactions(userId).first.then(
          (optionLocalTransactions) => optionLocalTransactions.fold(
            () {},
            (transactions) => _transactionsRemoteDataSource
                .addOrUpdateTransactions(transactions),
          ),
        );
  }

  // Scheduled Transactions

  @override
  Future<void> saveScheduledTransaction(
    ScheduledTransaction scheduledTransaction,
  ) async {
    await _transactionsLocalDataSource
        .cacheScheduledTransaction(scheduledTransaction);
    await _transactionsRemoteDataSource
        .addOrUpdateScheduledTransaction(scheduledTransaction);
  }

  @override
  Stream<Option<List<ScheduledTransaction>>> fetchScheduledTransactions(
    TransactionUserId userId, {
    required bool isFirstTimeOpen,
  }) async* {
    if (_isFirstTimeOpen) _getRemoteScheduledTransactions(userId);
    yield* _transactionsLocalDataSource
        .getCachedScheduledTransactions(userId)
        .asyncMap(
          (optionCachedTransactions) => optionCachedTransactions.fold(
            () => Future.value(None()),
            (cachedScheduledTransactions) =>
                Future.value(some(cachedScheduledTransactions)),
          ),
        );
  }

  Future<void> _getRemoteScheduledTransactions(TransactionUserId userId) =>
      _transactionsRemoteDataSource.getAllScheduledTransactions().first.then(
            (optionRemoteTransactions) => optionRemoteTransactions.fold(
              () {},
              (remoteScheduledTransactions) async {
                await _transactionsLocalDataSource
                    .cacheScheduledTransactions(remoteScheduledTransactions);
                _isFirstTimeOpen = false;
              },
            ),
          );

  @override
  Future<void> deleteScheduled(TransactionId transactionId) async {
    await _transactionsLocalDataSource
        .deleteScheduledTransaction(transactionId);
    await _transactionsRemoteDataSource
        .deleteScheduledTransaction(transactionId);
  }

  @override
  Future<void> deleteAllScheduled() async {
    await _transactionsLocalDataSource.deleteAllScheduledTransactions();
    await _transactionsRemoteDataSource.deleteAllScheduledTransactions();
  }

  @override
  Future<void> backUpScheduled(TransactionUserId userId) async {
    _transactionsLocalDataSource
        .getCachedScheduledTransactions(userId)
        .first
        .then(
          (optionLocalTransactions) => optionLocalTransactions.fold(
            () {},
            (scheduledTransactions) => _transactionsRemoteDataSource
                .addOrUpdateScheduledTransactions(scheduledTransactions),
          ),
        );
  }
}
