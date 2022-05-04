import 'dart:core';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../../common/extensions.dart';
import '../../../core/accounts/domain.dart';
import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';
import 'edit_account_bloc/edit_account_screen_bloc.dart';

class EditAccountScreen extends StatefulWidget {
  final Account? account;
  const EditAccountScreen({
    Key? key,
    required this.account,
  }) : super(key: key);
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  late EditAccountScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<EditAccountScreenBloc>()
      ..add(CheckAccount(account: widget.account));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditAccountScreenBloc, EditAccountScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, EditAccountScreenState state) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: CustomScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            CupertinoSliverNavigationBar(
              stretch: true,
              largeTitle: Text(
                state.isEditMode
                    ? AppLocalizations.of(context)!.accounts_edit_account
                    : AppLocalizations.of(context)!.accounts_new_account,
              ),
              previousPageTitle: AppLocalizations.of(context)!.misc_back,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if ([
                    state.account?.id.value != 'bank',
                    state.account?.id.value != 'cash',
                    state.account?.id.value != 'wallet',
                    state.isEditMode
                  ].flatten())
                    GestureDetector(
                      child: Icon(
                        CupertinoIcons.trash_circle,
                        color: AppColors.red,
                        size: 24,
                      ),
                      onTap: () {
                        bloc.add(AccountDeleted());
                        AppNavigator.navigateBack(context);
                      },
                    ),
                  SizedBox(width: 8),
                  GestureDetector(
                    child: Icon(
                      CupertinoIcons.checkmark_circle,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                    onTap: () {
                      if (state.account!.name.isEmpty) return;
                      bloc.add(AccountSaved());
                      AppNavigator.navigateBack(context);
                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Material(
                child: _buildBody(context, state),
              ),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            state.isEditMode
                ? AppLocalizations.of(context)!.accounts_edit_account
                : AppLocalizations.of(context)!.accounts_new_account,
          ),
          actions: [
            if ([
              state.account?.id.value != 'bank',
              state.account?.id.value != 'cash',
              state.account?.id.value != 'wallet',
              state.isEditMode
            ].flatten())
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: AppColors.red,
                ),
                onPressed: () {
                  bloc.add(AccountDeleted());
                  AppNavigator.navigateBack(context);
                },
              ),
            IconButton(
              icon: Icon(
                Icons.check,
              ),
              onPressed: () {
                if (state.account!.name.isEmpty) return;
                bloc.add(AccountSaved());
                AppNavigator.navigateBack(context);
              },
            ),
          ],
        ),
        body: _buildBody(context, state),
      );
    }
  }

  Widget _buildBody(BuildContext context, EditAccountScreenState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      NetworkImage? image;
      Icon? accountIcon;
      bool isImageAvailable;
      final account = state.account;

      if ((account!.imageUrl ?? '').isEmpty) {
        isImageAvailable = false;
        accountIcon = Icon(
          IconData(
            account.icon,
            fontFamily: 'MaterialIcons',
          ),
          size: 40,
          color: AppColors.white,
        );
      } else {
        isImageAvailable = true;
        image = NetworkImage(account.imageUrl!);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Center(
            child: InkWell(
              onTap: () {
                _showEditOptions(context, bloc, state);
              },
              child: Stack(
                alignment: Alignment(1, 1.2),
                children: [
                  CircleAvatar(
                    maxRadius: 40,
                    backgroundColor: Color(account.color),
                    backgroundImage: image,
                    child: isImageAvailable ? null : accountIcon,
                  ),
                  CircleAvatar(
                    maxRadius: 15,
                    child: Icon(
                      Icons.edit,
                      color: AppColors.white,
                      size: 15,
                    ),
                    backgroundColor: AppColors.greySecondary,
                  ),
                ],
              ),
            ),
          ),
          if (Platform.isAndroid) ...[
            SizedBox(height: 20),
            Divider(height: 2),
          ],
          Padding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 8,
            ),
            child: Text(
              'GENERAL',
              style: TextStyle(fontWeight: FontWeight.w200),
              textAlign: TextAlign.start,
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.drive_file_rename_outline_outlined),
                minLeadingWidth: 2,
                title: Text(AppLocalizations.of(context)!.misc_name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state.account!.name.isNotEmpty)
                      Text(
                        state.account!.name,
                        style: TextStyle(color: AppColors.greySecondary),
                      ),
                    if (state.account!.name.isEmpty)
                      Text(
                        AppLocalizations.of(context)!.misc_required,
                        style: TextStyle(color: AppColors.red),
                      ),
                    SizedBox(width: 10),
                    if (Platform.isIOS) const Icon(CupertinoIcons.forward),
                  ],
                ),
                onTap: () => AppNavigator.navigateToEditAccountNamePage(
                  context,
                  name: state.account!.name,
                ),
              ),
              if (Platform.isIOS) Divider(height: 2),
              ListTile(
                leading: Icon(
                  IconData(
                    state.account!.icon,
                    fontFamily: 'MaterialIcons',
                  ),
                ),
                minLeadingWidth: 2,
                title: Text(AppLocalizations.of(context)!.misc_type),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.account!.typeAsString,
                      style: TextStyle(color: AppColors.greySecondary),
                    ),
                    SizedBox(width: 10),
                    if (Platform.isIOS) const Icon(CupertinoIcons.forward),
                  ],
                ),
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => _EditTypeBottomSheet(
                      state: state,
                      onCancelPressed: () {},
                      onTypeSelected: (accountType) {
                        bloc.add(TypeChanged(accountType));
                        AppNavigator.navigateBack(context);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      );
    }
  }
}

Future<void> _showEditOptions(
  BuildContext context,
  EditAccountScreenBloc bloc,
  EditAccountScreenState state,
) async {
  await showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        if ((state.account!.imageUrl ?? '').isEmpty)
          CupertinoActionSheetAction(
            child: Text(AppLocalizations.of(context)!.global_change_color),
            onPressed: () {
              Navigator.pop(context);
              _pickColor(context, bloc, state);
            },
          ),
        CupertinoActionSheetAction(
          child: Text(AppLocalizations.of(context)!.accounts_select_logo),
          onPressed: () {
            Navigator.pop(context);
            _pickImage(context, bloc, state);
          },
        ),
        if ((state.account!.imageUrl ?? '').isNotEmpty)
          CupertinoActionSheetAction(
            child: Text(
              AppLocalizations.of(context)!.accounts_delete_logo,
              style: TextStyle(
                color: AppColors.red,
              ),
            ),
            onPressed: () {
              bloc.add(LogoDeleted());
              Navigator.pop(context);
            },
          )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          AppLocalizations.of(context)!.misc_cancel,
          style: TextStyle(color: AppColors.red),
        ),
        onPressed: () => Navigator.pop(context),
      ),
    ),
  );
}

Future _pickColor(
  BuildContext context,
  EditAccountScreenBloc bloc,
  EditAccountScreenState state,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      title: Text(
        AppLocalizations.of(context)!.global_select_color,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(AppLocalizations.of(context)!.misc_close),
        )
      ],
      content: MaterialColorPicker(
        allowShades: false,
        selectedColor: Color(state.account!.color),
        onMainColorChange: (colorSwatch) {
          bloc.add(ColorUpdated(colorSwatch!.value));
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}

Future _pickImage(
  BuildContext context,
  EditAccountScreenBloc bloc,
  EditAccountScreenState state,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      title: Text(
        AppLocalizations.of(context)!.accounts_select_logo,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(AppLocalizations.of(context)!.misc_close),
        )
      ],
      content: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width * .66,
        child: GridView.count(
          crossAxisCount: 4,
          padding: const EdgeInsets.all(6.0),
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          children: <String>[
            AccountDefaultLogos.bancolombia,
            AccountDefaultLogos.davivienda,
            AccountDefaultLogos.nuBank,
            AccountDefaultLogos.bbva,
            AccountDefaultLogos.falabella,
            AccountDefaultLogos.bancoDeBogota,
            AccountDefaultLogos.bancoDeOccidente,
            AccountDefaultLogos.avvillas,
            AccountDefaultLogos.scotiabank,
            AccountDefaultLogos.cajaSocial,
            AccountDefaultLogos.bankOfAmerica,
            AccountDefaultLogos.chase,
            AccountDefaultLogos.wellsFargo,
            AccountDefaultLogos.cash,
            AccountDefaultLogos.binance,
            AccountDefaultLogos.metamask,
          ]
              .map(
                (url) => InkWell(
                  onTap: () {
                    bloc.add(LogoSelected(url));
                    Navigator.of(context).pop();
                  },
                  child: GridTile(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(url),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}

class _EditTypeBottomSheet extends StatelessWidget {
  final Function(AccountType) onTypeSelected;
  final VoidCallback onCancelPressed;
  final EditAccountScreenState state;

  const _EditTypeBottomSheet({
    Key? key,
    required this.onTypeSelected,
    required this.onCancelPressed,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(
          color: _isDarkMode ? AppColors.greyPrimary : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                alignment: FractionalOffset.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.greyPrimary,
                      ),
                      onPressed: () => AppNavigator.navigateBack(context),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.accounts_edit_account,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: kDefaultPadding,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 8,
              ),
              child: Text(
                AppLocalizations.of(context)!
                    .accounts_account_types
                    .toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
                textAlign: TextAlign.start,
              ),
            ),
            Divider(height: 2),
            ListTile(
              leading: Icon(AppIcons.bank),
              minLeadingWidth: 2,
              title:
                  Text(AppLocalizations.of(context)!.accounts_banking_account),
              trailing: state.account!.type == AccountType.bank
                  ? Icon(Icons.check, color: AppColors.primaryColor)
                  : null,
              onTap: () => onTypeSelected(AccountType.bank),
            ),
            Divider(height: 2),
            ListTile(
              leading: Icon(AppIcons.cash),
              minLeadingWidth: 2,
              title: Text(AppLocalizations.of(context)!.accounts_cash),
              trailing: state.account!.type == AccountType.cash
                  ? Icon(Icons.check, color: AppColors.primaryColor)
                  : null,
              onTap: () => onTypeSelected(AccountType.cash),
            ),
            Divider(height: 2),
            ListTile(
              leading: Icon(AppIcons.wallet),
              minLeadingWidth: 2,
              title: Text(AppLocalizations.of(context)!.accounts_wallet),
              trailing: state.account!.type == AccountType.wallet
                  ? Icon(Icons.check, color: AppColors.primaryColor)
                  : null,
              onTap: () => onTypeSelected(AccountType.wallet),
            ),
            Divider(height: 2),
          ],
        ),
      ),
    );
  }
}
