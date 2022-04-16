import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';
import '../../../utils/observer.dart';
import '../widgets/cash_flow_meter.dart';

class CashFlowGraph extends StatelessWidget {
  const CashFlowGraph({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: AppLocalizations.of(context)!.stats_cash_flow_graph,
      content: Observer<StatsBloc, StatsState>(
        onSuccess: (context, state) {
          return CashFlowMeter(
            incomes: state.incomes,
            expenses: state.expenses,
          );
        },
        onFailure: (context, state) => NoTransactionsWidget(onDate: state.date),
      ),
    );
  }
}
