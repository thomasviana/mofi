import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mofi/core/user/application.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/transactions/application.dart';
import '../../../../core/transactions/domain.dart';
import '../../utils/observer.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

@injectable
class TransactionsBloc extends Bloc<TransactionEvent, TransactionsState> {
  GetIsFirstTimeOpen getIsFirstTimeOpen;
  GetTransactions getTransactions;
  DeleteTransaction deleteTransaction;
  BackUpTransactions backUpTransactions;

  TransactionsBloc(
    this.getIsFirstTimeOpen,
    this.getTransactions,
    this.deleteTransaction,
    this.backUpTransactions,
  ) : super(TransactionsState.initial()) {
    on<TransactionsRequested>(_onTransactionsRequested);
    on<TransactionDeleted>(_onTransactionDeleted);
    on<TxsDateUpdated>(_onTxsDateUpdated);
    on<ToggleSortOption>(_onToggleSortOption);
    on<BackUpTransactionsEvent>(_onBackUpTransactionsEvent);
  }

  Future<void> _onTransactionsRequested(
    TransactionsRequested event,
    Emitter emit,
  ) async {
    await emit.onEach<Option<List<Transaction>>>(
      getIsFirstTimeOpen().switchMap(
        (value) => getTransactions(isFirstTimeOpen: value),
      ),
      onData: (optionTransactions) => optionTransactions.fold(
        () => emit(
          state.copyWith(
            transactions: [],
            status: Status.failure,
          ),
        ),
        (transactions) => transactions.isEmpty
            ? emit(state.copyWith(status: Status.failure))
            : emit(
                state.copyWith(
                  transactions: transactions,
                  status: Status.success,
                ),
              ),
      ),
    );
  }

  Future<void> _onTransactionDeleted(
    TransactionDeleted event,
    Emitter emit,
  ) =>
      deleteTransaction(event.transactionId);

  Future<void> _onTxsDateUpdated(TxsDateUpdated event, Emitter emit) async =>
      emit(state.copyWith(date: event.date));

  Future<void> _onToggleSortOption(
    ToggleSortOption event,
    Emitter emit,
  ) async {
    if (state.sortOption == SortOption.ascending) {
      emit(state.copyWith(sortOption: SortOption.descending));
    } else {
      emit(state.copyWith(sortOption: SortOption.ascending));
    }
  }

  Future<void> _onBackUpTransactionsEvent(
    BackUpTransactionsEvent event,
    Emitter<TransactionsState> emit,
  ) =>
      backUpTransactions();
}
