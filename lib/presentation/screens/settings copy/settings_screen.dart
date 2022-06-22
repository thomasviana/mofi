import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/auth/auth_bloc.dart';
import '../../core/settings/settings_bloc.dart';
import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: CustomScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverNavigationBar(
              stretch: true,
              largeTitle: Text(AppLocalizations.of(context)!.misc_settings),
              trailing: GestureDetector(
                child: const Icon(
                  CupertinoIcons.restart,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
                onTap: () => _showResetOption(context),
              ),
            ),
            SliverToBoxAdapter(
              child: SettingsContent(),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.misc_settings,
          ),
          actions: [
            IconButton(
              onPressed: () => _showResetOption(context),
              icon: const Icon(
                Icons.restart_alt,
              ),
            )
          ],
        ),
        body: SettingsContent(),
      );
    }
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.misc_profile),
          leading: const Icon(Icons.person_outline),
          trailing: Platform.isIOS ? const Icon(CupertinoIcons.forward) : null,
          onTap: () {
            AppNavigator.navigateToProfilePage(context);
          },
        ),
        Divider(height: 2),
        ListTile(
          title: Text(AppLocalizations.of(context)!.misc_categories),
          leading: const Icon(Icons.folder_open),
          trailing: Platform.isIOS ? const Icon(CupertinoIcons.forward) : null,
          onTap: () => AppNavigator.navigateToCategoriesPage(context),
        ),
        Divider(height: 2),
        ListTile(
          title: Text(AppLocalizations.of(context)!.misc_accounts),
          leading: const Icon(Icons.account_balance),
          trailing: Platform.isIOS ? const Icon(CupertinoIcons.forward) : null,
          onTap: () => AppNavigator.navigateToAccountsPage(context),
        ),
        Divider(height: 2),
        ListTile(
          title: Text(AppLocalizations.of(context)!.misc_budgets),
          leading: const Icon(Icons.all_inbox),
          trailing: Platform.isIOS ? const Icon(CupertinoIcons.forward) : null,
          onTap: () => AppNavigator.navigateToBudgetsPage(context),
        ),
        Divider(height: 2),
        ListTile(
          title: Text(AppLocalizations.of(context)!.settings_app_data),
          leading: const Icon(Icons.backup),
          trailing: Platform.isIOS ? const Icon(CupertinoIcons.forward) : null,
          onTap: () => AppNavigator.navigateToBackupPage(context),
        ),
        Divider(height: 2),
        ListTile(
          title: Text(
            AppLocalizations.of(context)!.misc_logOut,
            style: TextStyle(color: AppColors.red),
          ),
          leading: const Icon(Icons.logout, color: AppColors.red),
          onTap: () {
            context.read<AuthBloc>().add(LogoutRequested());
            AppNavigator.navigateBackToAuthPage(context);
          },
        ),
        Divider(height: 2),
      ],
    );
  }
}

void _showResetOption(
  BuildContext context,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => CustomAlertDialog(
      title: AppLocalizations.of(context)!
          .settings_app_data_restore_data_dialog_title,
      content: AppLocalizations.of(context)!
          .settings_app_data_restore_data_dialog_content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<SettingsBloc>().add(ResetFromFactoryRequested());
          },
          child: Text(
            AppLocalizations.of(context)!
                .settings_app_data_restore_data_dialog_restore,
            style: TextStyle(
              color: AppColors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(
            AppLocalizations.of(context)!.misc_cancel,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}
