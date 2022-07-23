import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/stats/stats_bloc.dart';
import '../../resources/resources.dart';
import 'components/incomes_by_account.dart';
import 'components/incomes_by_category.dart';
import 'components/incomes_by_type.dart';
import 'components/recurring_incomes.dart';

class IncomesScreen extends StatelessWidget {
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
                  largeTitle: Text(AppLocalizations.of(context)!.misc_incomes),
                  previousPageTitle: AppLocalizations.of(context)!.misc_back,
                ),
              if (Platform.isAndroid)
                SliverAppBar(
                  title: Text(
                    AppLocalizations.of(context)!.misc_incomes,
                  ),
                  elevation: 0.5,
                  floating: true,
                  pinned: true,
                ),
              SliverPersistentHeader(
                pinned: true,
                delegate: DateFilterDelegate(),
              ),
              RecurringIncomes(),
              IncomesByType(),
              IncomesByCategory(),
              IncomesByAccount(),
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
