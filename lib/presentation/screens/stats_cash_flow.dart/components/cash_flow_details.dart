import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common/extensions.dart';
import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';
import '../../../utils/observer.dart';

class CashFlowDetails extends StatelessWidget {
  const CashFlowDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: AppLocalizations.of(context)!.stats_cash_flow_detail,
      content: Observer<StatsBloc, StatsState>(
        onSuccess: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      Icon(Icons.arrow_forward_rounded, color: AppColors.white),
                ),
                title: Text(AppLocalizations.of(context)!
                    .stats_cash_flow_total_incomes),
                trailing: Text(state.incomes.toCurrencyFormat()),
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.arrow_back_rounded, color: AppColors.white),
                ),
                title: Text(AppLocalizations.of(context)!
                    .stats_cash_flow_total_expenses),
                trailing: Text(state.expenses.toCurrencyFormat()),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.global_cash_flow,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    state.balance.toCurrencyFormat(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          );
        },
        onFailure: (context, state) => NoTransactionsWidget(onDate: state.date),
      ),
    );
  }
}
