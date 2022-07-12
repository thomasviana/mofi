import 'package:cron/cron.dart';
import 'package:injectable/injectable.dart';

import '../../../user/application.dart';
import '../../domain.dart';

@injectable
class ScheduleTransaction {
  final TransactionRepository _transactionRepository;
  final GetProfileInfo _getProfileInfo;
  final Cron _cron;

  const ScheduleTransaction(
    this._transactionRepository,
    this._getProfileInfo,
    this._cron,
  );

  Future<void>? call({
    required TransactionType txType,
    required String title,
    required double amount,
    required DateTime date,
    required String note,
    required int icon,
    required int color,
    TransactionUserId? txUserId,
    TransactionCategoryId? txCategoryId,
    TransactionSubCategoryId? txSubCategoryId,
    TransactionAccountId? txAccountId,
    TransactionBudgetId? txBudgetId,
    IncomeType? incomeType,
    bool isIncomeManaged = false,
    BudgetManagementMap? budgetManagement,
    required DateTime dueDate,
  }) async {
    final user = await _getProfileInfo().first;
    user.fold(
      () => null,
      (user) async {
        await _transactionRepository.saveScheduledTransaction(
          ScheduledTransaction(
            dueDate: dueDate,
            transaction: Transaction(
              id: TransactionId.auto(),
              transactionType: txType,
              title: title,
              amount: amount,
              date: date,
              note: note,
              icon: icon,
              color: color,
              txUserId: TransactionUserId(user.id.value),
              txAccountId: txAccountId,
              txCategoryId: txCategoryId,
              txSubCategoryId: txSubCategoryId,
              txBudgetId: txBudgetId,
              incomeType: incomeType,
              isIncomeManaged: isIncomeManaged,
              budgetManagement: budgetManagement,
            ),
          ),
        );
        );
        _cron.schedule(
          Schedule.parse('/5 * * * * *'),
          () async => _transactionRepository.save(transaction),
        );
      },
    );
  }
}
