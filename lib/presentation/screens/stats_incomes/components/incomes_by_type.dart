import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common/extensions.dart';
import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';
import '../../../utils/observer.dart';

class IncomesByType extends StatelessWidget {
  const IncomesByType({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: AppLocalizations.of(context)!.stats_incomes_by_type,
      content: Observer<StatsBloc, StatsState>(
        onSuccess: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.global_incomes_ai,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
                title: Text(
                  AppLocalizations.of(context)!.stats_incomes_active_incomes,
                ),
                trailing: Text(state.activeIncomes.toCurrencyFormat()),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.global_incomes_pi,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
                title: Text(
                  AppLocalizations.of(context)!.stats_incomes_pasive_incomes,
                ),
                trailing: Text(state.pasiveIncomes.toCurrencyFormat()),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.misc_total,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    state.incomes.toCurrencyFormat(),
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
