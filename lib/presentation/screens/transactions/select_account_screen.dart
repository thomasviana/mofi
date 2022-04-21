import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/accounts/domain.dart';
import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';
import 'edit_transaction_bloc/edit_transaction_screen_bloc.dart';

class SelectAccountScreen extends StatelessWidget {
  final List<Account> accounts;
  const SelectAccountScreen({
    Key? key,
    required this.accounts,
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
        title: Text(AppLocalizations.of(context)!.misc_account),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text(AppLocalizations.of(context)!.misc_edit),
              onPressed: () => AppNavigator.navigateToAccountsPage(context),
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
              AppLocalizations.of(context)!.misc_accounts.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w200),
              textAlign: TextAlign.start,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: accounts.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 0),
            itemBuilder: (BuildContext context, int index) {
              NetworkImage? image;
              Icon? accountIcon;
              bool isImageAvailable;
              final account = accounts[index];
              if (account.imageUrl != null) {
                isImageAvailable = true;
                image = NetworkImage(account.imageUrl!);
              } else {
                isImageAvailable = false;
                accountIcon = Icon(
                  IconData(
                    account.icon,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: AppColors.white,
                );
              }
              return ListTile(
                leading: CircleAvatar(
                  maxRadius: 20,
                  backgroundColor: Color(account.color),
                  backgroundImage: image,
                  child: isImageAvailable ? null : accountIcon,
                ),
                title: Text(
                  account.name,
                ),
                trailing: state.account.fold(
                  () {
                    if (account.id == accounts.first.id) {
                      return Icon(Icons.check, color: AppColors.primaryColor);
                    }
                    return null;
                  },
                  (stateAccount) {
                    if (stateAccount.id == account.id) {
                      return Icon(Icons.check, color: AppColors.primaryColor);
                    }
                    return null;
                  },
                ),
                onTap: () {
                  context
                      .read<EditTransactionScreenBloc>()
                      .add(AccountSelected(account: account));
                  Navigator.pop(context);
                },
              );
            },
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }
}
