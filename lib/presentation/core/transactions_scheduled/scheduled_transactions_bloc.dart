import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mofi/core/user/application.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/transactions/application.dart';
import '../../../../core/transactions/domain.dart';
import '../../utils/observer.dart';

part 'scheduled_transactions_event.dart';
part 'scheduled_transactions_state.dart';

@injectable
class ScheduledTransactionsBloc
    extends Bloc<ScheduledTransactionEvent, ScheduledTransactionsState> {
  GetIsFirstTimeOpen getIsFirstTimeOpen;
  GetScheduledTransactions getScheduledTransactions;
  DeleteScheduledTransaction deleteScheduledTransaction;
  BackUpScheduledTransactions backUpScheduledTransactions;

  ScheduledTransactionsBloc(
    this.getIsFirstTimeOpen,
    this.getScheduledTransactions,
    this.deleteScheduledTransaction,
    this.backUpScheduledTransactions,
  ) : super(ScheduledTransactionsState.initial()) {
    on<ScheduledTransactionsRequested>(_onScheduledTransactionsRequested);
    on<ScheduledTransactionDeleted>(_onScheduledTransactionDeleted);
    on<ScheduledTxsDateUpdated>(_onScheduledTxsDateUpdated);
    on<BackUpScheduledTransactionsEvent>(_onBackUpScheduledTransactionsEvent);
  }

  Future<void> _onScheduledTransactionsRequested(
    ScheduledTransactionsRequested event,
    Emitter emit,
  ) async {
    await emit.onEach<Option<List<ScheduledTransaction>>>(
      getIsFirstTimeOpen().switchMap(
        (value) => getScheduledTransactions(isFirstTimeOpen: value),
      ),
      onData: (optionTransactions) => optionTransactions.fold(
        () => emit(
          state.copyWith(
            scheduledTransactions: [],
            status: Status.failure,
          ),
        ),
        (scheduledTransactions) => scheduledTransactions.isEmpty
            ? emit(state.copyWith(status: Status.failure))
            : emit(
                state.copyWith(
                  scheduledTransactions: scheduledTransactions,
                  status: Status.success,
                ),
              ),
      ),
    );
  }

  Future<void> _onScheduledTransactionDeleted(
    ScheduledTransactionDeleted event,
    Emitter emit,
  ) =>
      deleteScheduledTransaction(event.transactionId);

  Future<void> _onScheduledTxsDateUpdated(
    ScheduledTxsDateUpdated event,
    Emitter emit,
  ) async =>
      emit(state.copyWith(date: event.date));

  Future<void> _onBackUpScheduledTransactionsEvent(
    BackUpScheduledTransactionsEvent event,
    Emitter<ScheduledTransactionsState> emit,
  ) =>
      backUpScheduledTransactions();
}
