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
            (cachedTransactions) => Future.value(some(cachedTransactions)),
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
  Future<void> backUp(TransactionUserId userId) async {
    _transactionsLocalDataSource.getCachedTransactions(userId).first.then(
          (optionLocalTransactions) => optionLocalTransactions.fold(
            () {},
            (transactions) => _transactionsRemoteDataSource
                .addOrUpdateTransactions(transactions),
          ),
        );
  }
}
