import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:mofi/core/transactions/domain.dart';

class TransactionDto {
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
  TransactionDto({
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
  });

  factory TransactionDto.fromDomain(Transaction transaction) {
    final transactionType =
        TransactionType.values[transaction.transactionType.index];
    final incomeType = IncomeType.values[transaction.incomeType!.index];

    return TransactionDto(
      id: transaction.id.value,
      transactionType: transactionType.index,
      title: transaction.title,
      amount: transaction.amount,
      date: transaction.date,
      note: transaction.note,
      icon: transaction.icon,
      color: transaction.color,
      txUserId: transaction.txUserId!.value,
      txCategoryId: transaction.txCategoryId!.value,
      txSubCategoryId: transaction.txSubCategoryId!.value,
      txAccountId: transaction.txAccountId!.value,
      txBudgetId: transaction.txBudgetId!.value,
      incomeType: incomeType.index,
      isIncomeManaged: transaction.isIncomeManaged,
      budgetManagement: transaction.budgetManagement,
    );
  }

  Transaction toDomain() {
    final userId = TransactionUserId(txUserId);
    final categoryId = TransactionCategoryId(txCategoryId);
    final subCategoryId = TransactionSubCategoryId(txSubCategoryId);
    final accountId = TransactionAccountId(txAccountId);
    final budgetId = TransactionBudgetId(txBudgetId);
    final txType = TransactionType.values[transactionType];
    final incType = IncomeType.values[incomeType ?? 0];

    return Transaction(
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
  }

  factory TransactionDto.fromFirebaseMap(Map<String?, Object?> data) {
    return TransactionDto(
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
      budgetManagement:
          ((data['budgetManagement'] ?? {}) as Map<String, dynamic>)
              .map((key, value) => MapEntry(key, value as double)),
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
    };
  }
}
