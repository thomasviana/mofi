part of 'scheduled_transactions_bloc.dart';

enum SortOption { ascending, descending }

class ScheduledTransactionsState extends MyState {
  List<ScheduledTransaction> scheduledTransactions;
  DateTime date;

  ScheduledTransactionsState({
    required Status status,
    required this.scheduledTransactions,
    required this.date,
  }) : super(status: status);

  List<ScheduledTransaction> get filteredScheduledTransactions {
    final filteredScheduledTransactions = scheduledTransactions
        .where(
          (scheduledTransaction) => scheduledTransaction.transaction.date
              .isBefore(DateTime(date.year, date.month + 1)),
        )
        .toList()
      ..sort((a, b) => a.dueDate.day.compareTo(b.dueDate.day));
    return filteredScheduledTransactions;
  }

  factory ScheduledTransactionsState.initial() => ScheduledTransactionsState(
        status: Status.initial,
        scheduledTransactions: [],
        date: DateTime.now(),
      );

  ScheduledTransactionsState copyWith({
    Status? status,
    List<ScheduledTransaction>? scheduledTransactions,
    DateTime? date,
  }) {
    return ScheduledTransactionsState(
      status: status ?? this.status,
      scheduledTransactions:
          scheduledTransactions ?? this.scheduledTransactions,
      date: date ?? this.date,
    );
  }
}
