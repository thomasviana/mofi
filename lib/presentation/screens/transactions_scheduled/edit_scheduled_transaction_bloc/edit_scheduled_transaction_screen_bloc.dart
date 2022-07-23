import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as f;
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mofi/core/categories/application.dart';

import '../../../../core/accounts/domain.dart';
import '../../../../core/budgets/domain.dart';
import '../../../../core/categories/domain.dart';
import '../../../../core/transactions/application.dart';
import '../../../../core/transactions/domain.dart';
import '../../../resources/resources.dart';

part 'edit_scheduled_transaction_screen_event.dart';
part 'edit_scheduled_transaction_screen_state.dart';

@injectable
class EditScheduledTransactionScreenBloc extends Bloc<
    EditScheduledTransactionScreenEvent, EditScheduledTransactionScreenState> {
  ScheduleTransaction scheduleTransaction;
  UpdateScheduledTransaction updateScheduledTransaction;
  GetScheduledTransactions getScheduledTransactions;
  GetSubCategories getSubCategories;

  EditScheduledTransactionScreenBloc(
    this.scheduleTransaction,
    this.updateScheduledTransaction,
    this.getScheduledTransactions,
    this.getSubCategories,
  ) : super(EditScheduledTransactionScreenState.initial()) {
    on<CheckTransaction>(_onCheckTransaction);
    on<GetUserSubcategories>(_onGetUserSubcategories);
    on<GetAllUserSubcategories>(
      _onGetAllUserSubcategories,
    ); // For search subcategories feature
    on<SearchSubCategory>(_onSearchSubCategory);
    on<ScheduledTransactionSaved>(_onScheduledTransactionSaved);
    on<AmountUpdated>(_onAmountUpdated);
    on<AccountSelected>(_onAccountSelected);
    on<CategorySelected>(_onCategorySelected);
    on<SubCategorySelected>(_onSubCategorySelected);
    on<IncomeTypeChanged>(_onIncomeTypeChanged);
    on<BudgetSelected>(_onBudgetSelected);
    on<DueDateUpdated>(_onDueDateUpdated);
    on<NoteUpdated>(_onNoteUpdated);
    on<TimestampChanged>(_onTimestampChanged);
    on<Dispose>(_onDispose);
  }

  Future<void> _onCheckTransaction(
    CheckTransaction event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    if (event.scheduledTransaction != null) {
      final account = event.accounts.firstWhere(
        (account) =>
            account.id.value ==
            event.scheduledTransaction!.transaction.txAccountId!.value,
      );
      final subCategory = event.subCategories.firstWhere(
        (subCategory) =>
            subCategory.id.value ==
            event.scheduledTransaction!.transaction.txSubCategoryId!.value,
      );
      final budget = event.budgets.lastWhere(
        (budget) =>
            budget.id.value ==
            event.scheduledTransaction!.transaction.txBudgetId!.value,
      );
      emit(
        state.copyWith(
          transaction: event.scheduledTransaction!.transaction,
          isEditMode: true,
          isLoading: false,
          account: some(account),
          subCategory: some(subCategory),
          budget: some(budget),
          budgets: event.budgets,
          timestamp: f.Timestamp.fromDate(event.scheduledTransaction!.dueDate),
        ),
      );
    } else {
      emit(
        state.copyWith(
          transaction: state.transaction
              .copyWith(transactionType: event.transactionType),
          isLoading: false,
          account: optionOf(event.accounts.first),
          budget: optionOf(
            event.budgets.firstWhere((account) => account.id.value == 'seg'),
          ),
          budgets: event.budgets,
        ),
      );
    }
  }

  Future<void> _onGetUserSubcategories(
    GetUserSubcategories event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    await emit.onEach<List<SubCategory>>(
      state.category.fold(
        () => Stream.empty(),
        (category) => getSubCategories(category.id),
      ),
      onData: (subCategories) =>
          emit(state.copyWith(subCategories: subCategories)),
    );
  }

  Future<void> _onGetAllUserSubcategories(
    GetAllUserSubcategories event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    await emit.onEach<Option<List<SubCategory>>>(
      getSubCategories.all(),
      onData: (optionSubCategories) => optionSubCategories.fold(
        () => emit(state.copyWith(allSubCategories: [])),
        (allSubCategories) =>
            emit(state.copyWith(allSubCategories: allSubCategories)),
      ),
    );
  }

  Future<void> _onSearchSubCategory(
    SearchSubCategory event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    final suggestions = state.allSubCategories!.where((subCategory) {
      final nameLower = subCategory.name.toLowerCase();
      final searchLower = event.query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();
    emit(
      state.copyWith(query: event.query, subCategorySuggestions: suggestions),
    );
  }

  Future<void> _onScheduledTransactionSaved(
    ScheduledTransactionSaved event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    if (state.isEditMode) {
      await updateScheduledTransaction(
        transactionId: state.transaction.id,
        title:
            state.subCategory.fold(() => '', (subCategory) => subCategory.name),
        amount: event.amount,
        date: state.transaction.date,
        note: state.transaction.note,
        icon: state.subCategory
            .fold(() => 0xe532, (subCategory) => subCategory.icon),
        color: state.subCategory.fold(
          () => AppColors.primaryColor.value,
          (subCategory) => subCategory.color,
        ),
        txAccountId: state.account.fold(
          () => null,
          (account) => TransactionAccountId(account.id.value),
        ),
        txBudgetId: state.budget.fold(
          () => null,
          (budget) => TransactionBudgetId(budget.id.value),
        ),
        txCategoryId: state.category.fold(
          () => null,
          (category) => TransactionCategoryId(category.id.value),
        ),
        txType: state.transaction.transactionType,
        incomeType: state.transaction.incomeType,
        dueDate: state.timestamp.toDate(),
      );
    } else {
      await scheduleTransaction(
        title:
            state.subCategory.fold(() => '', (subCategory) => subCategory.name),
        amount: event.amount,
        date: state.transaction.date,
        note: state.transaction.note ?? '',
        icon: state.subCategory
            .fold(() => 0xe532, (subCategory) => subCategory.icon),
        color: state.subCategory.fold(
          () => AppColors.primaryColor.value,
          (subCategory) => subCategory.color,
        ),
        txAccountId: state.account.fold(
          () => null,
          (account) => TransactionAccountId(account.id.value),
        ),
        txBudgetId: state.budget.fold(
          () => null,
          (budget) => TransactionBudgetId(budget.id.value),
        ),
        txCategoryId: state.category.fold(
          () => state.subCategory.fold(
            () => null,
            (subCategory) =>
                TransactionCategoryId(subCategory.categoryId.value),
          ),
          (category) => TransactionCategoryId(category.id.value),
        ),
        txSubCategoryId: state.subCategory.fold(
          () => null,
          (subCategory) => TransactionSubCategoryId(subCategory.id.value),
        ),
        txType: state.transaction.transactionType,
        incomeType: state.transaction.incomeType,
        dueDate: state.timestamp.toDate(),
      );
    }
  }

  Future<void> _onAmountUpdated(
    AmountUpdated event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        transaction: state.transaction.copyWith(
          amount: event.amount,
          isIncomeManaged: false,
          budgetManagement: {},
        ),
      ),
    );
  }

  Future<void> _onAccountSelected(
    AccountSelected event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    emit(
      state.copyWith(account: some(event.account)),
    );
  }

  Future<void> _onCategorySelected(
    CategorySelected event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    await getSubCategories(event.category.id).first.then(
          (subCategories) => emit(
            state.copyWith(
              subCategories: subCategories,
              category: some(event.category),
            ),
          ),
        );
  }

  Future<void> _onSubCategorySelected(
    SubCategorySelected event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        subCategory: some(event.subCategory),
      ),
    );
  }

  Future<void> _onIncomeTypeChanged(
    IncomeTypeChanged event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        transaction: state.transaction.copyWith(
          incomeType: IncomeType.values[event.index!],
        ),
      ),
    );
  }

  Future<void> _onBudgetSelected(
    BudgetSelected event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    emit(
      state.copyWith(budget: some(event.budget)),
    );
  }

  Future<void> _onDueDateUpdated(
    DueDateUpdated event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        transaction: state.transaction.copyWith(date: event.date),
      ),
    );
  }

  Future<void> _onNoteUpdated(
    NoteUpdated event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        transaction: state.transaction.copyWith(note: event.note),
      ),
    );
  }

  Future<void> _onTimestampChanged(
    TimestampChanged event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        transaction: state.transaction.copyWith(date: event.timestamp.toDate()),
        timestamp: event.timestamp,
      ),
    );
  }

  Future<void> _onDispose(
    Dispose event,
    Emitter<EditScheduledTransactionScreenState> emit,
  ) async {
    emit(EditScheduledTransactionScreenState.initial());
  }
}
