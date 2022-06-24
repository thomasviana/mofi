import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain.dart';
import '../../../../infrastructure.dart';

@lazySingleton
class ScheduledTransactionMapper {
  const ScheduledTransactionMapper();

  ScheduledTransaction fromDbDto(ScheduledTransactionDbDto dto) {
    final id = TransactionId(dto.id);
    final userId = TransactionUserId(dto.userId!);
    final accountId = TransactionAccountId(dto.accountId!);
    final categoryId = TransactionCategoryId(dto.categoryId!);
    final subCategoryId = TransactionSubCategoryId(dto.subCategoryId!);
    final budgetId = TransactionBudgetId(dto.budgetId!);
    final txType = TransactionType.values[dto.transactionType.index];
    final incomeType = IncomeType.values[dto.incomeType!.index];
    final transaction = Transaction(
      id: id,
      transactionType: txType,
      title: dto.title,
      amount: dto.amount,
      date: dto.date,
      note: dto.note,
      icon: dto.icon,
      color: dto.color,
      txUserId: userId,
      txAccountId: accountId,
      txCategoryId: categoryId,
      txSubCategoryId: subCategoryId,
      txBudgetId: budgetId,
      incomeType: incomeType,
      isIncomeManaged: dto.isIncomeManaged,
      budgetManagement: dto.budgetManagement!.budgetToAmount,
    );

    return ScheduledTransaction(
      transaction: transaction,
      dueDate: dto.dueDate,
    );
  }

  List<ScheduledTransaction> fromDbDtoList(
    List<ScheduledTransactionDbDto> dtos,
  ) =>
      dtos.map((dto) => fromDbDto(dto)).toList();

  ScheduledTransactionsTableCompanion toDbDto(
    ScheduledTransaction scheduledTransaction,
  ) {
    final incomeType = IncomeTypeTable
        .values[scheduledTransaction.transaction.incomeType!.index];
    final transactionType = TransactionTypeTable
        .values[scheduledTransaction.transaction.transactionType.index];
    final BudgetManagement budgetManagement = BudgetManagement(
      budgetToAmount: scheduledTransaction.transaction.budgetManagement,
    );
    return ScheduledTransactionsTableCompanion(
      id: Value(scheduledTransaction.transaction.id.value),
      transactionType: Value(transactionType),
      title: Value(scheduledTransaction.transaction.title!),
      amount: Value(scheduledTransaction.transaction.amount),
      date: Value(scheduledTransaction.transaction.date),
      note: Value(scheduledTransaction.transaction.note!),
      icon: Value(scheduledTransaction.transaction.icon),
      color: Value(scheduledTransaction.transaction.color),
      userId: Value(scheduledTransaction.transaction.txUserId!.value),
      accountId: Value(scheduledTransaction.transaction.txAccountId!.value),
      categoryId: Value(scheduledTransaction.transaction.txCategoryId!.value),
      subCategoryId:
          Value(scheduledTransaction.transaction.txSubCategoryId!.value),
      budgetId: Value(scheduledTransaction.transaction.txBudgetId!.value),
      incomeType: Value(incomeType),
      isIncomeManaged: Value(scheduledTransaction.transaction.isIncomeManaged),
      budgetManagement: Value(budgetManagement),
      dueDate: Value(scheduledTransaction.dueDate),
    );
  }

  List<ScheduledTransactionsTableCompanion> toDbDtoList(
    List<ScheduledTransaction> transactions,
  ) {
    return transactions.map((transaction) => toDbDto(transaction)).toList();
  }
}
