import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/stats/stats_bloc.dart';
import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';
import 'widgets/stat_card.dart';
import 'widgets/trailing_pie_chart.dart';
import 'widgets/trailing_progress_bars.dart';

class StatsScreen extends StatefulWidget {
  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          return CustomScrollView(
            shrinkWrap: true,
            slivers: [
              if (Platform.isIOS)
                CupertinoSliverNavigationBar(
                  stretch: true,
                  largeTitle: Text(AppLocalizations.of(context)!.misc_stats),
                ),
              if (Platform.isAndroid)
                SliverAppBar(
                  title: Text(
                    AppLocalizations.of(context)!.misc_stats,
                  ),
                  elevation: 0.5,
                  floating: true,
                  pinned: true,
                ),
              SliverPersistentHeader(
                pinned: true,
                delegate: DateFilterDelegate(),
              ),
              StatsCard(
                title: AppLocalizations.of(context)!.misc_incomes.toUpperCase(),
                amount: state.incomes,
                trailing: TrailingPieChart(data: state.incomeCategoriesData),
                onTap: () => AppNavigator.navigateToIncomesPage(context),
              ),
              StatsCard(
                title:
                    AppLocalizations.of(context)!.misc_expenses.toUpperCase(),
                amount: state.expenses,
                trailing: TrailingPieChart(data: state.expenseCategoriesData),
                onTap: () => AppNavigator.navigateToExpensesPage(context),
              ),
              StatsCard(
                title: AppLocalizations.of(context)!
                    .global_cash_flow
                    .toUpperCase(),
                amount: state.balance,
                trailing: state.balance == 0
                    ? const Icon(
                        Icons.thumbs_up_down_rounded,
                        size: 50,
                        color: AppColors.greyDisabled,
                      )
                    : state.balance > 0
                        ? const Icon(
                            Icons.thumb_up_rounded,
                            size: 50,
                            color: AppColors.green,
                          )
                        : Icon(
                            Icons.thumb_down_rounded,
                            size: 50,
                            color: AppColors.red.withOpacity(0.7),
                          ),
                onTap: () => AppNavigator.navigateToCashFlowPage(context),
              ),
              StatsCard(
                title: AppLocalizations.of(context)!.misc_budgets.toUpperCase(),
                amount: state.expenses,
                trailing: TrailingProgressBars(data: state.budgetsData),
                onTap: () => AppNavigator.navigateToBudgetsStatsPage(context),
              ),
              SliverToBoxAdapter(
                child: const SizedBox(height: 16),
              )
            ],
          );
        },
      ),
    );
  }
}
