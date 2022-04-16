import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';
import '../../../utils/observer.dart';

class ExpensesByCategory extends StatelessWidget {
  const ExpensesByCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: AppLocalizations.of(context)!.stats_expenses_by_category,
      content: Observer<StatsBloc, StatsState>(
        onSuccess: (context, state) {
          return PieChartWidget(
            data: state.expenseCategoriesData,
            total: state.expenses,
          );
        },
        onFailure: (context, state) => NoTransactionsWidget(onDate: state.date),
      ),
    );
  }
}
