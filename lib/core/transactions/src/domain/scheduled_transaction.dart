import 'package:mofi/core/transactions/domain.dart';

class ScheduledTransaction {
  final DateTime dueDate;
  final Transaction transaction;

  ScheduledTransaction({
    required this.dueDate,
    required this.transaction,
  });

  factory ScheduledTransaction.empty() => ScheduledTransaction(
        dueDate: DateTime.now(),
        transaction: Transaction.empty(),
      );
}
