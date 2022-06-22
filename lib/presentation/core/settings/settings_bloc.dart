import 'dart:async';
import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mofi/core/transactions/application.dart';
import 'package:mofi/core/user/application.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/accounts/application.dart';
import '../../../core/accounts/domain.dart';
import '../../../core/budgets/application.dart';
import '../../../core/budgets/domain.dart';
import '../../../core/categories/application.dart';
import '../../../core/categories/domain.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  GetIsFirstTimeOpen getIsFirstTimeOpen;
  SetFirstTimeOpenToFalse setFirstTimeOpenToFalse;
  GetAccounts getAccounts;
  GetCategories getCategories;
  GetSubCategories getSubCategories;
  GetBudgets getBudgets;
  SetDefaultAccounts setDefaultAccounts;
  SetDefaultCategories setDefaultCategories;
  SetDefaultSubCategories setDefaultSubCategories;
  SetDefaultBudgets setDefaultBudgets;
  ResetAccounts resetAccounts;
  ResetCategories resetCategories;
  ResetBudgets resetBudgets;
  ResetTransactions resetTransactions;
  BackUpCategories backUpCategories;
  BackUpAccounts backUpAccounts;
  BackUpBudgets backUpBudgets;

  SettingsBloc(
    this.getIsFirstTimeOpen,
    this.setFirstTimeOpenToFalse,
    this.getAccounts,
    this.getCategories,
    this.getSubCategories,
    this.getBudgets,
    this.setDefaultAccounts,
    this.setDefaultCategories,
    this.setDefaultSubCategories,
    this.setDefaultBudgets,
    this.resetAccounts,
    this.resetCategories,
    this.resetBudgets,
    this.resetTransactions,
    this.backUpCategories,
    this.backUpAccounts,
    this.backUpBudgets,
  ) : super(SettingsState.initial()) {
    on<GetUserAccounts>(_onGetUserAccounts);
    on<GetUserCategories>(_onGetUserCategories);
    on<GetUserSubCategories>(_onGetUserSubCategories);
    on<GetUserBudgets>(_onGetUserBudgets);
    on<ResetFromFactoryRequested>(_onResetFromFactoryRequested);
    on<BackUpData>(_onBackUpData);
    developer.log('getUserSettings');
  }

  Future<void> _onGetUserAccounts(
    GetUserAccounts event,
    Emitter<SettingsState> emit,
  ) async {
    await emit.onEach<Option<List<Account>>>(
      getIsFirstTimeOpen().switchMap(
        (value) => getAccounts(isFirstTimeOpen: value),
      ),
      onData: (userAccounts) => userAccounts.fold(
        () => setDefaultAccounts(),
        (accounts) => emit(state.copyWith(accounts: accounts)),
      ),
    );
  }

  Future<void> _onGetUserCategories(
    GetUserCategories event,
    Emitter<SettingsState> emit,
  ) async {
    await emit.onEach<Option<List<Category>>>(
      getIsFirstTimeOpen().switchMap(
        (value) => getCategories(isFirstTimeOpen: value),
      ),
      onData: (optionCategories) => optionCategories.fold(
        () => setDefaultCategories(),
        (categories) {
          emit(state.copyWith(categories: categories));
          if (categories.isNotEmpty) setFirstTimeOpenToFalse();
        },
      ),
    );
  }

  Future<void> _onGetUserSubCategories(
    GetUserSubCategories event,
    Emitter<SettingsState> emit,
  ) async {
    await emit.onEach<Option<List<SubCategory>>>(
      getSubCategories.all(),
      onData: (optionSubCategories) => optionSubCategories.fold(
        () => emit(state.copyWith(subCategories: [])),
        (subCategories) => emit(state.copyWith(subCategories: subCategories)),
      ),
    );
  }

  Future<void> _onGetUserBudgets(
    GetUserBudgets event,
    Emitter<SettingsState> emit,
  ) async {
    await emit.onEach<Option<List<Budget>>>(
      getIsFirstTimeOpen().switchMap(
        (value) => getBudgets(isFirstTimeOpen: value),
      ),
      onData: (userBudgets) => userBudgets.fold(
        () => setDefaultBudgets(),
        (budgets) => emit(state.copyWith(budgets: budgets)),
      ),
    );
  }

  Future<void> _onResetFromFactoryRequested(
    ResetFromFactoryRequested event,
    Emitter<SettingsState> emit,
  ) async {
    await resetCategories();
    await resetBudgets();
    await resetAccounts();
    await resetTransactions();
    await setDefaultCategories();
    add(BackUpData());
  }

  Future<void> _onBackUpData(
    BackUpData event,
    Emitter<SettingsState> emit,
  ) async {
    await backUpCategories();
    await backUpAccounts();
    await backUpBudgets();
  }
}
