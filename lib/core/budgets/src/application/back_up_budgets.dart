import 'package:injectable/injectable.dart';
import 'package:mofi/core/user/application.dart';

import '../../domain.dart';

@injectable
class BackUpBudgets {
  final GetProfileInfo _getProfileInfo;
  final BudgetRepository _budgetRepository;

  const BackUpBudgets(
    this._getProfileInfo,
    this._budgetRepository,
  );

  Future<void> call() async {
    final user = await _getProfileInfo().first;
    user.fold(
      () {},
      (user) => _budgetRepository.backUp(BudgetUserId(user.id.value)),
    );
  }
}
