import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mofi/core/budgets/domain.dart';
import 'package:mofi/core/budgets/infrastructure.dart';

abstract class BudgetsRemoteDataSource {
  Future<void> addOrUpdateBudget(Budget budget);
  Future<void> addOrUpdateBudgets(List<Budget> budgets);
  Stream<Option<List<Budget>>> getAllBudgets();
  Future<void> deleteBudget(BudgetId budgetId);
  Future<void> deleteAllBudgets();
}

@LazySingleton(as: BudgetsRemoteDataSource)
class BudgetsRemoteDataSourceImpl implements BudgetsRemoteDataSource {
  final BudgetsFirebaseProvider _budgetsFirebaseProvider;

  BudgetsRemoteDataSourceImpl(
    this._budgetsFirebaseProvider,
  );

  @override
  Future<void> addOrUpdateBudget(Budget budget) =>
      _budgetsFirebaseProvider.addOrUpdateBudget(budget);

  @override
  Future<void> addOrUpdateBudgets(List<Budget> budgets) async {
    for (final budget in budgets) {
      await _budgetsFirebaseProvider.addOrUpdateBudget(budget);
    }
  }

  @override
  Stream<Option<List<Budget>>> getAllBudgets() =>
      _budgetsFirebaseProvider.getBudgets();

  @override
  Future<void> deleteBudget(BudgetId budgetId) =>
      _budgetsFirebaseProvider.deleteBudget(budgetId);

  @override
  Future<void> deleteAllBudgets() =>
      _budgetsFirebaseProvider.deleteAllBudgets();
}
