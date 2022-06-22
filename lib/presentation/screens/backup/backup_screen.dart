import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../core/settings/settings_bloc.dart';
import '../../core/transactions/transactions_bloc.dart';
import '../../resources/resources.dart';

class BackupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            GradientMask(
              colorA: AppColors.primaryVariant,
              colorB: AppColors.primaryColor,
              child: Icon(
                Icons.backup_outlined,
                size: 150,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.settings_app_data,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.greyBackground,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!
                            .settings_app_data_restore_data_dialog_title,
                      ),
                      leading: const Icon(Icons.person_outline),
                      onTap: () => _showRestoreConfirmationDialog(
                        context,
                        onRestore: () => BlocProvider.of<SettingsBloc>(context)
                            .add(ResetFromFactoryRequested()),
                      ),
                    ),
                    Divider(height: 2),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context)!
                            .settings_app_data_backup_data_dialog_title,
                      ),
                      leading: const Icon(Icons.backup_rounded),
                      onTap: () => _showBackupConfirmationDialog(
                        context,
                        onBackup: () {
                          BlocProvider.of<SettingsBloc>(context)
                              .add(BackUpData());
                          BlocProvider.of<TransactionsBloc>(context)
                              .add(BackUpTransactionsEvent());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .settings_app_data_backup_data_last_backup,
                    style: TextStyle(color: AppColors.greySecondary),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat(
                      'MMM d,',
                      AppLocalizations.of(context)!.localeName,
                    ).add_jm().format(DateTime.now()),
                    style: TextStyle(color: AppColors.greySecondary),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showRestoreConfirmationDialog(
  BuildContext context, {
  required VoidCallback onRestore,
}) {
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
            onRestore();
            Navigator.pop(context);
            // context.read<SettingsBloc>().add(ResetFromFactoryRequested());
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

void _showBackupConfirmationDialog(
  BuildContext context, {
  required VoidCallback onBackup,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => CustomAlertDialog(
      title: AppLocalizations.of(context)!
          .settings_app_data_backup_data_dialog_title,
      content: AppLocalizations.of(context)!
          .settings_app_data_backup_data_dialog_content,
      actions: [
        TextButton(
          onPressed: () {
            onBackup();
            Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.of(context)!
                .settings_app_data_backup_data_dialog_backup,
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
