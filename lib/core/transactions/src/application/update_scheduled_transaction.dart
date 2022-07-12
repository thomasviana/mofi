import 'package:injectable/injectable.dart';

import '../../application.dart';
import '../../domain.dart';

@injectable
class UpdateScheduledTransaction {
  final TransactionRepository _transactionRepository;
  final GetScheduledTransactions _getScheduledTransactions;

  const UpdateScheduledTransaction(
    this._transactionRepository,
    this._getScheduledTransactions,
  );

  Future<void> call({
    required TransactionId transactionId,
    String? title,
    double? amount,
    DateTime? date,
    String? note,
    int? icon,
    int? color,
    TransactionAccountId? txAccountId,
    TransactionCategoryId? txCategoryId,
    TransactionBudgetId? txBudgetId,
    IncomeType? incomeType,
    TransactionType? txType,
    required DateTime dueDate,
  }) async {
    final scheduledTransaction =
        await _getScheduledTransactions(isFirstTimeOpen: false).first.then(
              (optionTransactions) => optionTransactions.fold(
                () => null,
                (scheduledTransactions) => scheduledTransactions.firstWhere(
                  (scheduledTransaction) =>
                      scheduledTransaction.transaction.id == transactionId,
                  orElse: () => throw Exception("Transaction doesn't exist."),
                ),
              ),
            );
    if (scheduledTransaction != null) {
      _transactionRepository.saveScheduledTransaction(
        ScheduledTransaction(
          dueDate: dueDate,
          transaction: scheduledTransaction.transaction.copyWith(
            transactionType: txType,
            title: title,
            amount: amount,
            date: date,
            note: note,
            icon: icon,
            color: color,
            txAccountId: txAccountId,
            txCategoryId: txCategoryId,
            txBudgetId: txBudgetId,
            incomeType: incomeType,
          ),
        ),
      );
    }
  }
}
