import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class GetBudgets {
  final BudgetRepository _budgetRepository;
  final GetProfileInfo _getProfileInfo;

  const GetBudgets(
    this._budgetRepository,
    this._getProfileInfo,
  );

  Stream<Option<List<Budget>>> call() async* {
    yield* _getProfileInfo().switchMap((user) {
      return user.fold(
        () => Stream.value(None()),
        (user) => _budgetRepository.fetchBudgets(BudgetUserId(user.id.value)),
      );
    });
  }
}
