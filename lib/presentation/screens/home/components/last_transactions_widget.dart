import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/budgets/domain.dart';
import '../../../../core/transactions/domain.dart';
import '../../../core/settings/settings_bloc.dart';
import '../../../core/transactions/transactions_bloc.dart';
import '../../../resources/resources.dart';
import '../../../routes/app_navigator.dart';
import '../../../utils/observer.dart';
import '../../main/main_app_cubit/main_screen_cubit.dart';

class LastTransactionsWidget extends StatelessWidget {
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
      title: AppLocalizations.of(context)!.home_last_transactions_title,
      actionTitle:
          AppLocalizations.of(context)!.home_last_transactions_view_all,
      onActionPressed: () =>
          context.read<MainScreenCubit>().onSelectedPageIndexChanged(2),
      content: Observer<TransactionsBloc, TransactionsState>(
        onSuccess: (context, state) {
          if (state.filteredTransactions.isNotEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final transaction = state.filteredTransactions[index];
                    return LastTransactionsListTile(
                      transaction: transaction,
                      budget: _getBudget(transaction.txBudgetId),
                      onPressed: () =>
                          AppNavigator.navigateToEditTransactionPage(
                        context,
                        transaction: transaction,
                      ),
                    );
                  },
                  itemCount: state.filteredTransactions.length < 4
                      ? state.filteredTransactions.length
                      : 4,
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
