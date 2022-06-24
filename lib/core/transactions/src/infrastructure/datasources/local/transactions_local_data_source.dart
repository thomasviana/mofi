import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

abstract class TransactionsLocalDataSource {
  Future<void> cacheTransaction(Transaction transaction);
  Future<void> cacheTransactions(List<Transaction> transactions);
  Stream<Option<List<Transaction>>> getCachedTransactions(
    TransactionUserId userId,
  );
  Future<void> deleteTransaction(TransactionId transactionId);
  Future<void> deleteAllTransactions();

  // Scheduled Transactions
  Future<void> cacheScheduledTransaction(
    ScheduledTransaction scheduledTransaction,
  );
  Future<void> cacheScheduledTransactions(
    List<ScheduledTransaction> scheduledTransaction,
  );
  Stream<Option<List<ScheduledTransaction>>> getCachedScheduledTransactions(
    TransactionUserId userId,
  );
}

@LazySingleton(as: TransactionsLocalDataSource)
class TransactionsLocalDataSourceImpl implements TransactionsLocalDataSource {
  final TransactionDao _transactionDao;
  final ScheduledTransactionDao _scheduledTransactionDao;
  final TransactionMapper _transactionMapper;
  final ScheduledTransactionMapper _scheduledTransactionMapper;

  TransactionsLocalDataSourceImpl(
    this._transactionDao,
    this._scheduledTransactionDao,
    this._transactionMapper,
    this._scheduledTransactionMapper,
  );

  @override
  Future<void> cacheTransaction(Transaction transaction) {
    return Future.value(_transactionMapper.toDbDto(transaction))
        .then((campanion) => _transactionDao.createOrUpdate(campanion));
  }

  @override
  Future<void> cacheTransactions(List<Transaction> transactions) {
    return Future.value(_transactionMapper.toDbDtoList(transactions)).then(
      (campanions) => {
        for (var campanion in campanions)
          {_transactionDao.createOrUpdate(campanion)}
      },
    );
  }

  @override
  Future<void> deleteTransaction(TransactionId transactionId) {
    return _transactionDao.deleteTransaction(transactionId.value);
  }

  @override
  Stream<Option<List<Transaction>>> getCachedTransactions(
    TransactionUserId userId,
  ) =>
      _transactionDao.getTransactions(userId.value).map(
            (dtos) => dtos.isEmpty
                ? none()
                : some(_transactionMapper.fromDbDtoList(dtos)),
          );

  @override
  Future<void> deleteAllTransactions() {
    return _transactionDao.deleteAllTransactions();
  }

  @override
  Future<void> cacheScheduledTransaction(
    ScheduledTransaction scheduledTransaction,
  ) {
    return Future.value(
      _scheduledTransactionMapper.toDbDto(scheduledTransaction),
    ).then(
      (campanion) => _scheduledTransactionDao.createOrUpdate(campanion),
    );
  }

  @override
  Stream<Option<List<ScheduledTransaction>>> getCachedScheduledTransactions(
    TransactionUserId userId,
  ) =>
      _scheduledTransactionDao.getTransactions(userId.value).map(
            (dtos) => dtos.isEmpty
                ? none()
                : some(_scheduledTransactionMapper.fromDbDtoList(dtos)),
          );

  @override
  Future<void> cacheScheduledTransactions(
    List<ScheduledTransaction> scheduledTransaction,
  ) {
    return Future.value(
            _scheduledTransactionMapper.toDbDtoList(scheduledTransaction))
        .then(
      (campanions) => {
        for (var campanion in campanions)
          {_scheduledTransactionDao.createOrUpdate(campanion)}
      },
    );
  }
}
