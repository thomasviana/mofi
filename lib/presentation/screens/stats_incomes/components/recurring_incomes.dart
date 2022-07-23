import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/budgets/domain.dart';
import '../../../../core/transactions/domain.dart';
import '../../../core/settings/settings_bloc.dart';
import '../../../core/transactions_scheduled/scheduled_transactions_bloc.dart';
import '../../../resources/resources.dart';
import '../../../routes/app_navigator.dart';
import '../../../utils/observer.dart';

class RecurringIncomes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Budget _getBudget(TransactionBudgetId? id) {
      final budgets = context.read<SettingsBloc>().state.budgets;
      final budget = budgets.firstWhere(
        (budget) => budget.id.value == id!.value,
      );
      return budget;
    }

    return WidgetCard(
      title: 'Recurring',
      actionIcon: Icon(
        Icons.add_circle,
        color: AppColors.primaryColor,
        size: 30,
      ),
      onActionPressed: () {
        HapticFeedback.mediumImpact();
        AppNavigator.navigateToEditScheduledTransactionPage(
          context,
          arguments: [TransactionType.income, null],
        );
      },
      content: Observer<ScheduledTransactionsBloc, ScheduledTransactionsState>(
        onSuccess: (context, state) {
          if (state.filteredScheduledTransactions.isNotEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final scheduledTransaction =
                        state.filteredScheduledTransactions[index];
                    return ScheduledTransactionListTile(
                      transaction: scheduledTransaction.transaction,
                      dueDate: scheduledTransaction.dueDate,
                      budget: _getBudget(
                        scheduledTransaction.transaction.txBudgetId,
                      ),
                      onPressed: () =>
                          AppNavigator.navigateToEditScheduledTransactionPage(
                        context,
                        arguments: [
                          scheduledTransaction.transaction.transactionType,
                          scheduledTransaction
                        ],
                      ),
                      onDeletePressed: (_) =>
                          context.read<ScheduledTransactionsBloc>().add(
                                ScheduledTransactionDeleted(
                                  transactionId:
                                      scheduledTransaction.transaction.id,
                                ),
                              ),
                    );
                  },
                  itemCount: state.filteredScheduledTransactions.length,
                ),
              ],
            );
          } else {
            return NoTransactionsWidget(onDate: state.date);
          }
        },
        onFailure: (context, state) => NoTransactionsWidget(onDate: state.date),
      ),
    );
  }
}
