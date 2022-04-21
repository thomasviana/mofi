import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/budgets/domain.dart';
import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';
import 'edit_transaction_bloc/edit_transaction_screen_bloc.dart';

class SelectBudgetScreen extends StatelessWidget {
  final List<Budget> budgets;
  const SelectBudgetScreen({
    Key? key,
    required this.budgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransactionScreenBloc, EditTransactionScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditTransactionScreenState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.misc_budget),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text(
                AppLocalizations.of(context)!.misc_edit,
                style: TextStyle(
                  color:
                      Platform.isIOS ? AppColors.primaryColor : AppColors.white,
                ),
              ),
              onPressed: () => AppNavigator.navigateToBudgetsPage(context),
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 8,
            ),
            child: Text(
              AppLocalizations.of(context)!.misc_budgets.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w200),
              textAlign: TextAlign.start,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: budgets.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 0),
            itemBuilder: (BuildContext context, int index) {
              final budget = budgets[index];
              bool hasAbbreviation = true;
              if (budget.abbreviation == null || budget.abbreviation!.isEmpty) {
                hasAbbreviation = false;
              }
              return ListTile(
                leading: CircleAvatar(
                  maxRadius: 20,
                  backgroundColor: Color(budget.color),
                  child: hasAbbreviation
                      ? Text(
                          budget.abbreviation!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        )
                      : Icon(
                          Icons.inbox,
                          color: AppColors.white,
                        ),
                ),
                title: Text(budget.name),
                trailing: state.budget.fold(
                  () => null,
                  (stateBudget) {
                    if (stateBudget.id == budget.id) {
                      return Icon(Icons.check, color: AppColors.primaryColor);
                    }
                    return null;
                  },
                ),
                onTap: () {
                  context
                      .read<EditTransactionScreenBloc>()
                      .add(BudgetSelected(budget: budget));
                  Navigator.pop(context);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
