import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';
import '../../infrastructure.dart';

@LazySingleton(as: BudgetRepository)
class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetsLocalDataSource _budgetsLocalDataSource;
  final BudgetsRemoteDataSource _budgetsRemoteDataSource;

  BudgetRepositoryImpl(
    this._budgetsLocalDataSource,
    this._budgetsRemoteDataSource,
  );

  bool _isFirstTimeOpen = true;

  @override
  Stream<Option<List<Budget>>> fetchBudgets(
    BudgetUserId userId, {
    required bool isFirstTimeOpen,
  }) async* {
    if (_isFirstTimeOpen) _getRemoteBudgetsOrSetDefault(userId);
    yield* _budgetsLocalDataSource.getCachedBudgets(userId).asyncMap(
          (optionCachedBudgets) => optionCachedBudgets.fold(
            () => Future.value(None()),
            (cachedBudgets) => Future.value(some(cachedBudgets)),
          ),
        );
  }

  Future<void> _getRemoteBudgetsOrSetDefault(BudgetUserId userId) =>
      _budgetsRemoteDataSource.getAllBudgets().first.then(
            (optionRemoteBudgets) => optionRemoteBudgets.fold(
              () async {
                final defaultBudgets = Budget.defaultBudgets;
                for (final budget in defaultBudgets) {
                  budget.setUserId(userId.value);
                }
                await saveList(defaultBudgets);
                _isFirstTimeOpen = false;
              },
              (remoteBudgets) async {
                await _budgetsLocalDataSource.cacheBudgets(remoteBudgets);
                _isFirstTimeOpen = false;
              },
            ),
          );

  @override
  Future<void> save(Budget budget) async {
    await _budgetsLocalDataSource.cacheBudget(budget);
    await _budgetsRemoteDataSource.addOrUpdateBudget(budget);
  }

  @override
  Future<void> saveList(List<Budget> budgets) async {
    return _budgetsLocalDataSource.cacheBudgets(budgets);
  }

  @override
  Future<void> delete(BudgetId budgetId) async {
    await _budgetsLocalDataSource.deleteBudget(budgetId);
    await _budgetsRemoteDataSource.deleteBudget(budgetId);
  }

  @override
  Future<void> deleteAll() async {
    await _budgetsLocalDataSource.deleteAllBudgets();
    await _budgetsRemoteDataSource.deleteAllBudgets();
  }

  @override
  Future<void> backUp(BudgetUserId userId) async {
    _budgetsLocalDataSource.getCachedBudgets(userId).first.then(
          (optionLocalBudgets) => optionLocalBudgets.fold(
            () {},
            (budgets) => _budgetsRemoteDataSource.addOrUpdateBudgets(budgets),
          ),
        );
  }
}
