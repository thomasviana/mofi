part of 'edit_scheduled_transaction_screen_bloc.dart';

abstract class EditScheduledTransactionScreenEvent {}

class CheckTransaction extends EditScheduledTransactionScreenEvent {
  final ScheduledTransaction? scheduledTransaction;
  final TransactionType? transactionType;
  final List<Account> accounts;
  final List<SubCategory> subCategories;
  final List<Budget> budgets;
  CheckTransaction({
    this.scheduledTransaction,
    this.transactionType,
    required this.accounts,
    required this.subCategories,
    required this.budgets,
  });
}

class GetUserSubcategories extends EditScheduledTransactionScreenEvent {}

class GetAllUserSubcategories extends EditScheduledTransactionScreenEvent {}

class SearchSubCategory extends EditScheduledTransactionScreenEvent {
  final String query;
  SearchSubCategory({required this.query});
}

class ScheduledTransactionSaved extends EditScheduledTransactionScreenEvent {
  final double amount;
  ScheduledTransactionSaved({
    required this.amount,
  });
}

class AmountUpdated extends EditScheduledTransactionScreenEvent {
  final double amount;
  AmountUpdated({
    required this.amount,
  });
}

class AccountSelected extends EditScheduledTransactionScreenEvent {
  final Account account;
  AccountSelected({
    required this.account,
  });
}

class CategorySelected extends EditScheduledTransactionScreenEvent {
  final Category category;
  CategorySelected({
    required this.category,
  });
}

class SubCategorySelected extends EditScheduledTransactionScreenEvent {
  final SubCategory subCategory;
  SubCategorySelected({
    required this.subCategory,
  });
}

class IncomeTypeChanged extends EditScheduledTransactionScreenEvent {
  final int? index;
  IncomeTypeChanged({
    this.index,
  });
}

class BudgetSelected extends EditScheduledTransactionScreenEvent {
  final Budget budget;
  BudgetSelected({
    required this.budget,
  });
}

class DueDateUpdated extends EditScheduledTransactionScreenEvent {
  final DateTime date;
  DueDateUpdated({
    required this.date,
  });
}

class NoteUpdated extends EditScheduledTransactionScreenEvent {
  final String note;
  NoteUpdated({
    required this.note,
  });
}

class TimestampChanged extends EditScheduledTransactionScreenEvent {
  final f.Timestamp timestamp;
  TimestampChanged({
    required this.timestamp,
  });
}

class Dispose extends EditScheduledTransactionScreenEvent {}
