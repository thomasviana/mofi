import 'package:flutter/material.dart';

import '../../core/accounts/domain.dart';
import '../../core/budgets/domain.dart';
import '../../core/categories/domain.dart';
import '../../core/transactions/domain.dart';

class AppNavigator {
  AppNavigator._();

  static const ROUTE_SPLASH_PAGE = Navigator.defaultRouteName;
  static const ROUTE_ONBOARDING_PAGE = '/onboarding';
  static const ROUTE_AUTH_PAGE = '/auth';
  static const ROUTE_MAIN_PAGE = '/main';

  //Stats
  static const ROUTE_INCOMES_PAGE = '/incomes';
  static const ROUTE_EXPENSES_PAGE = '/expenses';
  static const ROUTE_CASH_FLOW_PAGE = '/cash-flow';
  static const ROUTE_BUDGETS_STATS_PAGE = '/budgets-stats';

  // Settings
  static const ROUTE_PROFILE_PAGE = '/profile';

  static const ROUTE_CATEGORIES_PAGE = '/categories';
  static const ROUTE_EDIT_CATEGORY_PAGE = '/edit-category';
  static const ROUTE_EDIT_CATEGORY_NAME_PAGE = '/edit-category-name';
  static const ROUTE_SELECT_CATEGORY_TYPE_PAGE = '/select-category-type';
  static const ROUTE_EDIT_SUB_CATEGORY_PAGE = '/edit-sub-category';
  static const ROUTE_EDIT_SUB_CATEGORY_NAME_PAGE = '/edit-sub-category-name';

  static const ROUTE_ACCOUNTS_PAGE = '/accounts';
  static const ROUTE_EDIT_ACCOUNT_PAGE = '/edit-account';
  static const ROUTE_EDIT_ACCOUNT_NAME_PAGE = '/edit-account-name';

  static const ROUTE_BUDGETS_PAGE = '/budgets';
  static const ROUTE_EDIT_BUDGET_PAGE = '/edit-budget';
  static const ROUTE_EDIT_BUDGET_NAME_PAGE = '/edit-budget-name';
  static const ROUTE_EDIT_BUDGET_ABBREVIATION_PAGE =
      '/edit-budget-abbreviation';

  static const ROUTE_BACKUP_PAGE = '/backup';

  // Transactions
  static const ROUTE_EDIT_TRANSACTION_PAGE = '/edit-transaction';
  static const ROUTE_SELECT_ACCOUNT_PAGE = '/edit-transaction/select-account';
  static const ROUTE_SELECT_CATEGORY_PAGE = '/edit-transaction/select-category';
  static const ROUTE_SELECT_BUDGET_PAGE = '/edit-transaction/select-budget';
  static const ROUTE_EDIT_NOTE_PAGE = '/edit-transaction/edit-note';
  static const ROUTE_MANAGE_INCOME_PAGE = '/edit-transaction/manage-income';
  static const ROUTE_MANAGE_INCOME_BUDGET_PAGE =
      '/edit-transaction/manage-income-budget';

  // Scheduled Transactions
  static const ROUTE_EDIT_SCHEDULED_TRANSACTION_PAGE =
      '/edit-scheduled-transaction';
  static const ROUTE_EDIT_SCHEDULED_TRANSACTION_SELECT_ACCOUNT_PAGE =
      '/edit-scheduled-transaction/select-account';
  static const ROUTE_EDIT_SCHEDULED_TRANSACTION_SELECT_CATEGORY_PAGE =
      '/edit-scheduled-transaction/select-category';
  static const ROUTE_EDIT_SCHEDULED_TRANSACTION_SELECT_BUDGET_PAGE =
      '/edit-scheduled-transaction/select-budget';
  static const ROUTE_EDIT_SCHEDULED_TRANSACTION_EDIT_NOTE_PAGE =
      '/edit-scheduled-transaction/edit-note';

  static void navigateBack(BuildContext context) => Navigator.pop(context);

  static void closeFlow(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    while (navigator.canPop()) {
      navigator.maybePop();
    }
  }

  static void navigateToOnboardingPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, ROUTE_ONBOARDING_PAGE);
  }

  static void navigateToAuthPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_AUTH_PAGE);
  }

  static void navigateBackToAuthPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      ROUTE_AUTH_PAGE,
      (route) => false,
    );
  }

  static void navigateToMainPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      ROUTE_MAIN_PAGE,
      (route) => false,
    );
  }

  static void navigateBackToMainPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      ROUTE_MAIN_PAGE,
      (route) => false,
    );
  }

  static void navigateToIncomesPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_INCOMES_PAGE);
  }

  static void navigateToExpensesPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_EXPENSES_PAGE);
  }

  static void navigateToCashFlowPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_CASH_FLOW_PAGE);
  }

  static void navigateToBudgetsStatsPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_BUDGETS_STATS_PAGE);
  }

  static void navigateToProfilePage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_PROFILE_PAGE);
  }

  static void navigateToCategoriesPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_CATEGORIES_PAGE);
  }

  static void navigateToEditCategoryPage(
    BuildContext context, {
    Function(Object?)? then,
    Category? category,
  }) {
    Navigator.pushNamed(context, ROUTE_EDIT_CATEGORY_PAGE, arguments: category)
        .then(then ?? (_) {});
  }

  static void navigateToEditCategoryNamePage(
    BuildContext context, {
    String? name,
  }) {
    Navigator.pushNamed(
      context,
      ROUTE_EDIT_CATEGORY_NAME_PAGE,
      arguments: name,
    );
  }

  static void navigateToSelectCategoryTypePage(
    BuildContext context,
  ) {
    Navigator.pushNamed(
      context,
      ROUTE_SELECT_CATEGORY_TYPE_PAGE,
    );
  }

  static void navigateToEditSubCategoryPage(
    BuildContext context,
    SubCategory subCategory,
  ) {
    Navigator.pushNamed(
      context,
      ROUTE_EDIT_SUB_CATEGORY_PAGE,
      arguments: subCategory,
    );
  }

  static void navigateToEditSubCategoryNamePage(
    BuildContext context, {
    String? name,
  }) {
    Navigator.pushNamed(
      context,
      ROUTE_EDIT_SUB_CATEGORY_NAME_PAGE,
      arguments: name,
    );
  }

  static void navigateToAccountsPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_ACCOUNTS_PAGE);
  }

  static void navigateToEditAccountPage(
    BuildContext context, {
    Account? account,
  }) {
    Navigator.pushNamed(context, ROUTE_EDIT_ACCOUNT_PAGE, arguments: account);
  }

  static void navigateToEditAccountNamePage(
    BuildContext context, {
    String? name,
  }) {
    Navigator.pushNamed(
      context,
      ROUTE_EDIT_ACCOUNT_NAME_PAGE,
      arguments: name,
    );
  }

  static void navigateToBudgetsPage(BuildContext context) {
    Navigator.pushNamed(context, ROUTE_BUDGETS_PAGE);
  }

  static void navigateToEditBudgetPage(
    BuildContext context, {
    Budget? budget,
  }) {
    Navigator.pushNamed(context, ROUTE_EDIT_BUDGET_PAGE, arguments: budget);
  }

  static void navigateToEditBudgetNamePage(
    BuildContext context, {
    String? name,
  }) {
    Navigator.pushNamed(
      context,
      ROUTE_EDIT_BUDGET_NAME_PAGE,
      arguments: name,
    );
  }

  static void navigateToEditBudgetAbbreviationPage(
    BuildContext context, {
    String? abbreviation,
  }) {
    Navigator.pushNamed(
      context,
      ROUTE_EDIT_BUDGET_ABBREVIATION_PAGE,
      arguments: abbreviation,
    );
  }

  static void navigateToBackupPage(
    BuildContext context,
  ) {
    Navigator.pushNamed(
      context,
      ROUTE_BACKUP_PAGE,
    );
  }

  static void navigateToEditTransactionPage(
    BuildContext context, {
    Transaction? transaction,
  }) {
    Navigator.pushNamed(
      context,
      ROUTE_EDIT_TRANSACTION_PAGE,
      arguments: transaction,
    );
  }

  static void navigateToSelectAccountPage(
    BuildContext context,
    List<Account>? accounts,
  ) {
    Navigator.pushNamed(
      context,
      ROUTE_SELECT_ACCOUNT_PAGE,
      arguments: accounts,
    );
  }

  static void navigateToSelectCategoryPage(
    BuildContext context,
  ) {
    Navigator.pushNamed(context, ROUTE_SELECT_CATEGORY_PAGE);
  }

  static void navigateToSelectBudgetPage(
    BuildContext context, {
    List<Budget>? budgets,
  }) {
    Navigator.pushNamed(context, ROUTE_SELECT_BUDGET_PAGE, arguments: budgets);
  }

  static void navigateToEditNotePage(
    BuildContext context, {
    String? content,
  }) {
    Navigator.pushNamed(context, ROUTE_EDIT_NOTE_PAGE, arguments: content);
  }

  static void navigateToManageIncomePage(
    BuildContext context, {
    List<dynamic>? arguments,
  }) {
    Navigator.pushNamed(
      context,
      ROUTE_MANAGE_INCOME_PAGE,
      arguments: arguments,
    );
  }

  static void navigateToManageIncomeBudgetPage(
    BuildContext context, {
    List<dynamic>? arguments,
  }) {
    Navigator.pushNamed(
      context,
      ROUTE_MANAGE_INCOME_BUDGET_PAGE,
      arguments: arguments,
    );
  }

  static void navigateToEditScheduledTransactionPage(
    BuildContext context, {
    List<dynamic>? arguments,
  }) {
    Navigator.pushNamed(
      context,
      ROUTE_EDIT_SCHEDULED_TRANSACTION_PAGE,
      arguments: arguments,
    );
  }

  static void navigateToEditScheduledTransactionSelectAccountPage(
    BuildContext context,
    List<Account>? accounts,
  ) {
    Navigator.pushNamed(
      context,
      ROUTE_EDIT_SCHEDULED_TRANSACTION_SELECT_ACCOUNT_PAGE,
      arguments: accounts,
    );
  }

  static void navigateToEditScheduledTransactionSelectCategoryPage(
    BuildContext context,
  ) {
    Navigator.pushNamed(
      context,
      ROUTE_EDIT_SCHEDULED_TRANSACTION_SELECT_CATEGORY_PAGE,
    );
  }

  static void navigateToEditScheduledTransactionSelectBudgetPage(
    BuildContext context, {
    List<Budget>? budgets,
  }) {
    Navigator.pushNamed(
      context,
      ROUTE_EDIT_SCHEDULED_TRANSACTION_SELECT_BUDGET_PAGE,
      arguments: budgets,
    );
  }

  static void navigateToEditScheduledTransactionEditNotePage(
    BuildContext context, {
    String? content,
  }) {
    Navigator.pushNamed(
      context,
      ROUTE_EDIT_SCHEDULED_TRANSACTION_EDIT_NOTE_PAGE,
      arguments: content,
    );
  }
}
