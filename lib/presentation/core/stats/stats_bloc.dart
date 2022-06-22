import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mofi/core/user/application.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/transactions/domain.dart';
import '../../../common/extensions.dart';
import '../../../core/accounts/application.dart';
import '../../../core/accounts/domain.dart';
import '../../../core/budgets/application.dart';
import '../../../core/budgets/domain.dart';
import '../../../core/categories/application.dart';
import '../../../core/categories/domain.dart';
import '../../../core/transactions/application.dart';
import '../../utils/observer.dart';
import '../settings/settings_bloc.dart';

part 'stats_event.dart';
part 'stats_state.dart';

@injectable
class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final GetIsFirstTimeOpen _getIsFirstTimeOpen;
  final SetFirstTimeOpenToFalse _setFirstTimeOpenToFalse;
  final GetBudgets _getBudgets;
  final GetCategories _getCategories;
  final GetAccounts _getAccounts;
  final GetTransactions _getTransactions;

  StatsBloc(
    this._getIsFirstTimeOpen,
    this._setFirstTimeOpenToFalse,
    this._getBudgets,
    this._getCategories,
    this._getAccounts,
    this._getTransactions,
  ) : super(StatsState.initial()) {
    on<BudgetsSuscriptionRequested>(
      _onBudgetsSuscriptionRequested,
    );
    on<CategoriesSuscriptionRequested>(
      _onCategoriesSuscriptionRequested,
    );
    on<AccountsSuscriptionRequested>(
      _onAccountsSuscriptionRequested,
    );
    on<TransactionsSuscriptionRequested>(
      _onTransactionsSuscriptionRequested,
    );
    on<StatsDateUpdated>(_onStatsDateUpdated);
  }

  Future<void> _onBudgetsSuscriptionRequested(
    BudgetsSuscriptionRequested event,
    Emitter<StatsState> emit,
  ) async {
    await emit.onEach<Option<List<Budget>>>(
      _getBudgets(),
      onData: (optionBudgets) {
        return optionBudgets.fold(
          () => state.copyWith(budgets: []),
          (budgets) => emit(
            state.copyWith(
              budgets: budgets,
              status: Status.success,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onCategoriesSuscriptionRequested(
    CategoriesSuscriptionRequested event,
    Emitter<StatsState> emit,
  ) async {
    await emit.onEach<Option<List<Category>>>(
      _getIsFirstTimeOpen()
          .switchMap((value) => _getCategories(isFirstTimeOpen: value)),
      onData: (categories) {
        emit(
          state.copyWith(categories: categories.getOrElse(() => [])),
        );
        if (categories.isSome()) _setFirstTimeOpenToFalse();
      },
    );
  }

  Future<void> _onAccountsSuscriptionRequested(
    AccountsSuscriptionRequested event,
    Emitter<StatsState> emit,
  ) async {
    await emit.onEach<Option<List<Account>>>(
      _getIsFirstTimeOpen().switchMap(
        (value) => _getAccounts(isFirstTimeOpen: value),
      ),
      onData: (optionAccounts) {
        optionAccounts.fold(
          () => emit(
            state.copyWith(accounts: []),
          ),
          (accounts) {
            emit(
              state.copyWith(accounts: accounts),
            );
          },
        );
      },
    );
  }

  Future<void> _onTransactionsSuscriptionRequested(
    TransactionsSuscriptionRequested event,
    Emitter<StatsState> emit,
  ) async {
    await emit.onEach<Option<List<Transaction>>>(
      _getTransactions(),
      onData: (optionTransactions) {
        optionTransactions.fold(
          () => emit(
            state.copyWith(
              transactions: [],
              status: Status.success,
            ),
          ),
          (transactions) => emit(
            state.copyWith(
              transactions: transactions,
              status: Status.success,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onStatsDateUpdated(
    StatsDateUpdated event,
    Emitter<StatsState> emit,
  ) async {
    emit(
      state.copyWith(date: event.date),
    );
  }
}
