import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common/extensions.dart';
import '../../../core/stats/stats_bloc.dart';
import '../../../resources/resources.dart';
import '../../../routes/app_navigator.dart';
import '../../../utils/observer.dart';

class BudgetsInfoWidget extends StatelessWidget {
  const BudgetsInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: AppLocalizations.of(context)!.misc_budgets,
      actionTitle: AppLocalizations.of(context)!.global_view_more,
      onActionPressed: () => AppNavigator.navigateToBudgetsStatsPage(context),
      content: Column(
        children: [
          Observer<StatsBloc, StatsState>(
            onSuccess: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.misc_budget.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .butgets_spent_vs_budgeted
                            .toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 8),
                    itemCount: state.budgets.length,
                    itemBuilder: (BuildContext context, int index) {
                      final budgetData = state.budgetsData[index];
                      bool hasAbbreviation = true;
                      if (budgetData.abbreviation == null ||
                          budgetData.abbreviation!.isEmpty) {
                        hasAbbreviation = false;
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  hasAbbreviation
                                      ? budgetData.abbreviation!
                                      : budgetData.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${budgetData.spent.toCurrencyFormat()} / ${budgetData.budgeted.toCurrencyFormat()}',
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          AnimatedProgressBar(
                            currentValue: budgetData.percent,
                            displayText: '%',
                            backgroundColor:
                                AppColors.greyDisabled.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                            size: 20,
                            changeColorValue: 105,
                            changeProgressColor: AppColors.red.withOpacity(0.6),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
            onFailure: (context, state) =>
                NoTransactionsWidget(onDate: state.date),
          ),
        ],
      ),
    );
  }
}
