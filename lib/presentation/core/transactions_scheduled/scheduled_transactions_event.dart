part of 'scheduled_transactions_bloc.dart';

abstract class ScheduledTransactionEvent {}

class ScheduledTransactionsRequested extends ScheduledTransactionEvent {}

class ScheduledTransactionDeleted extends ScheduledTransactionEvent {
  final TransactionId transactionId;
  ScheduledTransactionDeleted({
    required this.transactionId,
  });
}

class ScheduledTxsDateUpdated extends ScheduledTransactionEvent {
  final DateTime date;
  ScheduledTxsDateUpdated({
    required this.date,
  });
}

class BackUpScheduledTransactionsEvent extends ScheduledTransactionEvent {}
