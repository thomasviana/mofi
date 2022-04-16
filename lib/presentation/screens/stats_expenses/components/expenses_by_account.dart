import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';
import '../../../utils/observer.dart';

class ExpensesByAccount extends StatefulWidget {
  const ExpensesByAccount({
    Key? key,
  }) : super(key: key);

  @override
  State<ExpensesByAccount> createState() => _ExpensesByAccountState();
}

class _ExpensesByAccountState extends State<ExpensesByAccount> {
  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: AppLocalizations.of(context)!.stats_expenses_by_account,
      content: Observer<StatsBloc, StatsState>(
        onSuccess: (context, state) {
          return PieChartWidget(
            data: state.expenseAccountsData,
            total: state.expenses,
          );
        },
        onFailure: (context, state) => NoTransactionsWidget(onDate: state.date),
      ),
    );
  }
}
