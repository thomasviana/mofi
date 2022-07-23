part of 'edit_transaction_screen_bloc.dart';

class EditTransactionScreenState {
  final Transaction transaction;
  final Option<Account> account;
  final Option<Category> category;
  final Option<SubCategory> subCategory;
  final List<SubCategory>? subCategories;
  final List<SubCategory>? allSubCategories;
  final List<SubCategory>? subCategorySuggestions;
  final Option<Budget> budget;
  final List<Budget> budgets;
  final f.Timestamp timestamp;
  final bool isLoading;
  final bool isEditMode;
  final String? query;

  EditTransactionScreenState({
    required this.transaction,
    required this.account,
    required this.category,
    required this.subCategory,
    this.subCategories,
    this.allSubCategories,
    this.subCategorySuggestions,
    required this.budget,
    required this.budgets,
    required this.timestamp,
    required this.isLoading,
    required this.isEditMode,
    this.query = '',
  });

  bool get isIncomeManaged =>
      transaction.isIncome && transaction.isIncomeManaged;
  bool get isSaveEnabled =>
      transaction.amount != 0 &&
      subCategory.isSome() &&
      (transaction.isIncome
          ? transaction.isIncomeManaged
          : transaction.isExpense);
  bool get isDefaultCategory => category.fold(
        () => false,
        (category) => Category.defaultCategories
            .any((defCategory) => defCategory.id.value == category.id.value),
      );

  SubCategory get generalSubCategory => (subCategories ?? [])
      .firstWhere((subCategory) => subCategory.id == subCategory.categoryId);

  List<SubCategory> get subCategoriesWithoutGeneral => (subCategories ?? [])
      .where((subCategory) => subCategory.id != subCategory.categoryId)
      .toList();

  factory EditTransactionScreenState.initial() => EditTransactionScreenState(
        transaction: Transaction.empty(),
        isLoading: true,
        isEditMode: false,
        account: none(),
        budget: none(),
        category: none(),
        subCategory: none(),
        subCategorySuggestions: [],
        budgets: [],
        timestamp: f.Timestamp.now(),
      );

  EditTransactionScreenState copyWith({
    Transaction? transaction,
    Option<Account>? account,
    Option<Category>? category,
    Option<SubCategory>? subCategory,
    List<SubCategory>? subCategories,
    List<SubCategory>? allSubCategories,
    List<SubCategory>? subCategorySuggestions,
    Option<Budget>? budget,
    List<Budget>? budgets,
    f.Timestamp? timestamp,
    bool? isLoading,
    bool? isEditMode,
    String? query,
  }) {
    return EditTransactionScreenState(
      transaction: transaction ?? this.transaction,
      account: account ?? this.account,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      subCategories: subCategories ?? this.subCategories,
      allSubCategories: allSubCategories ?? this.allSubCategories,
      subCategorySuggestions:
          subCategorySuggestions ?? this.subCategorySuggestions,
      budget: budget ?? this.budget,
      budgets: budgets ?? this.budgets,
      timestamp: timestamp ?? this.timestamp,
      isLoading: isLoading ?? this.isLoading,
      isEditMode: isEditMode ?? this.isEditMode,
      query: query ?? this.query,
    );
  }
}
