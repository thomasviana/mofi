import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/stats/stats_bloc.dart';
import '../../resources/resources.dart';
import 'components/expenses_by_account.dart';
import 'components/expenses_by_budget.dart';
import 'components/expenses_by_category.dart';

class ExpensesScreen extends StatelessWidget {
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
                  largeTitle: Text(AppLocalizations.of(context)!.misc_expenses),
                  previousPageTitle: AppLocalizations.of(context)!.misc_back,
                ),
              if (Platform.isAndroid)
                SliverAppBar(
                  title: Text(
                    AppLocalizations.of(context)!.misc_expenses,
                  ),
                  elevation: 0.5,
                  floating: true,
                  pinned: true,
                ),
              SliverPersistentHeader(
                pinned: true,
                delegate: DateFilterDelegate(),
              ),
              ExpensesByCategory(),
              ExpensesByBudget(),
              ExpensesByAccount(),
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
