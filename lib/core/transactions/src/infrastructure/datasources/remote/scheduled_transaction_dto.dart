import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:mofi/core/transactions/domain.dart';

class ScheduledTransactionDto {
  final String id;
  final int transactionType;
  final String? title;
  final double amount;
  final DateTime date;
  final String? note;
  final int icon;
  final int color;
  final String txUserId;
  final String txCategoryId;
  final String txSubCategoryId;
  final String txAccountId;
  final String txBudgetId;
  final int? incomeType;
  final bool isIncomeManaged;
  final Map<String, double>? budgetManagement;
  final DateTime dueDate;

  ScheduledTransactionDto({
    required this.id,
    required this.transactionType,
    this.title = '',
    this.amount = 0,
    required this.date,
    this.note = '',
    required this.icon,
    required this.color,
    required this.txUserId,
    required this.txCategoryId,
    required this.txSubCategoryId,
    required this.txAccountId,
    required this.txBudgetId,
    this.incomeType = 0,
    this.isIncomeManaged = false,
    required this.budgetManagement,
    required this.dueDate,
  });

  factory ScheduledTransactionDto.fromDomain(
    ScheduledTransaction scheduledTransaction,
  ) {
    final transactionType = TransactionType
        .values[scheduledTransaction.transaction.transactionType.index];
    final incomeType =
        IncomeType.values[scheduledTransaction.transaction.incomeType!.index];

    return ScheduledTransactionDto(
      id: scheduledTransaction.transaction.id.value,
      transactionType: transactionType.index,
      title: scheduledTransaction.transaction.title,
      amount: scheduledTransaction.transaction.amount,
      date: scheduledTransaction.transaction.date,
      note: scheduledTransaction.transaction.note,
      icon: scheduledTransaction.transaction.icon,
      color: scheduledTransaction.transaction.color,
      txUserId: scheduledTransaction.transaction.txUserId!.value,
      txCategoryId: scheduledTransaction.transaction.txCategoryId!.value,
      txSubCategoryId: scheduledTransaction.transaction.txSubCategoryId!.value,
      txAccountId: scheduledTransaction.transaction.txAccountId!.value,
      txBudgetId: scheduledTransaction.transaction.txBudgetId!.value,
      incomeType: incomeType.index,
      isIncomeManaged: scheduledTransaction.transaction.isIncomeManaged,
      budgetManagement: scheduledTransaction.transaction.budgetManagement,
      dueDate: scheduledTransaction.dueDate,
    );
  }

  ScheduledTransaction toDomain() {
    final userId = TransactionUserId(txUserId);
    final categoryId = TransactionCategoryId(txCategoryId);
    final subCategoryId = TransactionSubCategoryId(txSubCategoryId);
    final accountId = TransactionAccountId(txAccountId);
    final budgetId = TransactionBudgetId(txBudgetId);
    final txType = TransactionType.values[transactionType];
    final incType = IncomeType.values[incomeType ?? 0];
    final transaction = Transaction(
      id: TransactionId(id),
      transactionType: txType,
      title: title,
      amount: amount,
      date: date,
      note: note,
      icon: icon,
      color: color,
      txUserId: userId,
      txCategoryId: categoryId,
      txSubCategoryId: subCategoryId,
      txAccountId: accountId,
      txBudgetId: budgetId,
      incomeType: incType,
      budgetManagement: budgetManagement,
    );

    return ScheduledTransaction(
      transaction: transaction,
      dueDate: dueDate,
    );
  }

  factory ScheduledTransactionDto.fromFirebaseMap(Map<String?, Object?> data) {
    return ScheduledTransactionDto(
      id: data['id']! as String,
      transactionType: data['transactionType']! as int,
      title: data['title'] as String?,
      amount: data['amount']! as double,
      date: (data['date']! as Timestamp).toDate(),
      note: data['note'] as String?,
      icon: data['icon']! as int,
      color: data['color']! as int,
      txUserId: data['txUserId']! as String,
      txCategoryId: data['txCategoryId']! as String,
      txSubCategoryId: data['txSubCategoryId']! as String,
      txAccountId: data['txAccountId']! as String,
      txBudgetId: data['txBudgetId']! as String,
      incomeType: data['incomeType'] as int?,
      isIncomeManaged: data['isIncomeManaged']! as bool,
      budgetManagement: (data['budgetManagement']! as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as double)),
      dueDate: (data['dueDate']! as Timestamp).toDate(),
    );
  }

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'transactionType': transactionType,
      'title': title,
      'amount': amount,
      'date': date,
      'note': note,
      'icon': icon,
      'color': color,
      'txUserId': txUserId,
      'txCategoryId': txCategoryId,
      'txSubCategoryId': txSubCategoryId,
      'txAccountId': txAccountId,
      'txBudgetId': txBudgetId,
      'incomeType': incomeType,
      'isIncomeManaged': isIncomeManaged,
      'budgetManagement': budgetManagement,
      'dueDate': dueDate,
    };
  }
}
