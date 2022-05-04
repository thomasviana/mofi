import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/extensions.dart';
import '../../../core/budgets/domain.dart';
import '../../../core/transactions/domain.dart';
import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';
import 'edit_transaction_bloc/edit_transaction_screen_bloc.dart';
import 'manage_income_bloc/manage_income_screen_bloc.dart';

class ManageIncomeScreen extends StatefulWidget {
  final Transaction transaction;
  final List<Budget> budgets;
  const ManageIncomeScreen({
    Key? key,
    required this.transaction,
    required this.budgets,
  }) : super(key: key);
  @override
  State<ManageIncomeScreen> createState() => _ManageIncomeScreenState();
}

class _ManageIncomeScreenState extends State<ManageIncomeScreen> {
  late ManageIncomeScreenBloc bloc;
  late EditTransactionScreenBloc txBloc;

  @override
  void initState() {
    bloc = context.read<ManageIncomeScreenBloc>()
      ..add(
        CheckInitialValues(
          transaction: widget.transaction,
          budgets: widget.budgets,
        ),
      );
    txBloc = context.read<EditTransactionScreenBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageIncomeScreenBloc, ManageIncomeScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, ManageIncomeScreenState state) {
    final _isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.transactions_edit_transaction_manage,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                child: Text(
                  AppLocalizations.of(context)!.misc_done,
                  style: TextStyle(
                    color: state.isDoneEnabled
                        ? Platform.isIOS
                            ? AppColors.primaryColor
                            : AppColors.white
                        : AppColors.greyDisabled,
                  ),
                ),
                onPressed: state.isDoneEnabled
                    ? () {
                        final budgetsInfo = bloc.getBudgetsInfo();
                        txBloc.add(
                          IncomeManagementDone(budgetsInfo: budgetsInfo),
                        );
                        AppNavigator.navigateBack(context);
                      }
                    : null,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: kDefaultPadding),
              Text(AppLocalizations.of(context)!.misc_income),
              const SizedBox(height: 8),
              Text(
                widget.transaction.amount.toCurrencyFormat(),
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .transactions_manage_income_managed,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.managedAmount!.toCurrencyFormat(),
                          style: TextStyle(
                            color: AppColors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .transactions_manage_income_pending,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.pendingAmount!.toCurrencyFormat(),
                          style: TextStyle(
                            color: AppColors.amber,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding).copyWith(top: 0),
                child: Text(
                  AppLocalizations.of(context)!
                      .transactions_manage_instructions,
                  style: TextStyle(fontWeight: FontWeight.w200),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding).copyWith(top: 0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 9 / 7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.budgets!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final budget = state.budgets![index];
                    bool hasAbbreviation = true;
                    if (budget.abbreviation == null ||
                        budget.abbreviation!.isEmpty) {
                      hasAbbreviation = false;
                    }
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: _isDarkMode
                                ? AppColors.greyPrimary
                                : Colors.grey,
                            blurRadius: 4.0,
                            offset: Offset(0, 2.0),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                AppNavigator.navigateToManageIncomeBudgetPage(
                              context,
                              arguments: [state.budgets?[index], index],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(budget.color),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                hasAbbreviation
                                    ? budget.abbreviation!
                                    : budget.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                AppNavigator.navigateToManageIncomeBudgetPage(
                              context,
                              arguments: [state.budgets?[index], index],
                            ),
                            child: Text(
                              state.budgetAmounts![index].toCurrencyFormat(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                type: MaterialType.transparency,
                                clipBehavior: Clip.hardEdge,
                                shape: CircleBorder(),
                                child: IconButton(
                                  onPressed:
                                      state.isDecrementEnabled(index, 0.1)
                                          ? () => bloc.add(
                                                BudgetDecremented(
                                                  index: index,
                                                  step: 10,
                                                ),
                                              )
                                          : null,
                                  icon: Icon(
                                    Icons.remove,
                                    color: state.isDecrementEnabled(index, 0.1)
                                        ? _isDarkMode
                                            ? AppColors.white
                                            : AppColors.primaryColor
                                        : AppColors.greyDisabled,
                                  ),
                                ),
                              ),
                              Text(
                                state.budgetPercentages![index]
                                    .toPercentFormat(),
                              ),
                              Material(
                                type: MaterialType.transparency,
                                clipBehavior: Clip.hardEdge,
                                shape: CircleBorder(),
                                child: IconButton(
                                  onPressed:
                                      state.isIncrementEnabled(index, 0.1)
                                          ? () => bloc.add(
                                                BudgetIncremented(
                                                  index: index,
                                                  step: 10,
                                                ),
                                              )
                                          : null,
                                  icon: Icon(
                                    Icons.add,
                                    color: state.isIncrementEnabled(index, 0.1)
                                        ? _isDarkMode
                                            ? AppColors.white
                                            : AppColors.primaryColor
                                        : AppColors.greyDisabled,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
