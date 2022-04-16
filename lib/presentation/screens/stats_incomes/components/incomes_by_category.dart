import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';
import '../../../utils/observer.dart';

class IncomesByCategory extends StatelessWidget {
  const IncomesByCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: AppLocalizations.of(context)!.stats_incomes_by_category,
      content: Observer<StatsBloc, StatsState>(
        onSuccess: (context, state) {
          return PieChartWidget(
            data: state.incomeCategoriesData,
            total: state.incomes,
          );
        },
        onFailure: (context, state) => NoTransactionsWidget(onDate: state.date),
      ),
    );
  }
}
