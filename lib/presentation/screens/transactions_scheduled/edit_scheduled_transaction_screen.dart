import 'dart:io' show Platform;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart' as f;
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../common/extensions.dart';
import '../../../core/transactions/domain.dart';
import '../../core/settings/settings_bloc.dart';
import '../../resources/resources.dart';
import '../../routes/app_navigator.dart';
import 'edit_scheduled_transaction_bloc/edit_scheduled_transaction_screen_bloc.dart';

class EditScheduledTransactionScreen extends StatefulWidget {
  final TransactionType transactionType;
  final ScheduledTransaction? scheduledTransaction;
  const EditScheduledTransactionScreen({
    Key? key,
    required this.transactionType,
    this.scheduledTransaction,
  }) : super(key: key);
  @override
  _EditScheduledTransactionScreenState createState() =>
      _EditScheduledTransactionScreenState();
}

class _EditScheduledTransactionScreenState
    extends State<EditScheduledTransactionScreen>
    with SingleTickerProviderStateMixin {
  late EditScheduledTransactionScreenBloc bloc;
  late SettingsBloc settingsBloc;
  late CurrencyTextInputFormatter formatter;
  late Animation<double> _animation;
  late AnimationController _animationController;
  late ScrollController _scrollController;

  late double dateArrowTransform = 0;
  @override
  void initState() {
    settingsBloc = context.read<SettingsBloc>();
    bloc = context.read<EditScheduledTransactionScreenBloc>()
      ..add(
        CheckTransaction(
          scheduledTransaction: widget.scheduledTransaction,
          transactionType: widget.transactionType,
          accounts: settingsBloc.state.accounts,
          subCategories: settingsBloc.state.subCategories,
          budgets: settingsBloc.state.budgets,
        ),
      )
      ..add(GetAllUserSubcategories());
    formatter = CurrencyTextInputFormatter(symbol: '\$', decimalDigits: 0);

    initializeDateFormatting();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _animation =
        Tween<double>(begin: 0, end: pi / 2).animate(_animationController)
          ..addListener(() {
            setState(() {
              dateArrowTransform = _animation.value;
            });
          });
    _scrollController = ScrollController();
    super.initState();
  }

  void triggerArrowAnimation({bool collapsed = false}) {
    if (collapsed) _animationController.forward();
    if (!collapsed) _animationController.reverse();
  }

  Future<void> scrollDown({bool collapsed = false}) async {
    await Future.delayed(Duration(milliseconds: 300));
    final double end = _scrollController.position.maxScrollExtent;
    if (collapsed)
      _scrollController.animateTo(
        end,
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
      );
  }

  @override
  void dispose() {
    bloc.add(Dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditScheduledTransactionScreenBloc,
        EditScheduledTransactionScreenState>(
      builder: _buildState,
    );
  }

  Widget _buildState(
    BuildContext context,
    EditScheduledTransactionScreenState state,
  ) {
    if (state.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      // Account leading
      final account = state.account.fold(
        () => settingsBloc.state.accounts.first,
        (account) => account,
      );

      NetworkImage? image;
      Icon? accountIcon;
      bool isImageAvailable;
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

      // Budget leading
      final budget = state.budget.fold(
        () => settingsBloc.state.budgets.first,
        (budget) => budget,
      );
      bool hasAbbreviation = true;
      if (budget.abbreviation == null || budget.abbreviation!.isEmpty) {
        hasAbbreviation = false;
      }

      //Date Picker
      Widget buildDatePicker() => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SfDateRangePicker(
              initialSelectedDate: state.timestamp.toDate(),
              onSelectionChanged: (args) {
                if (args.value is DateTime) {
                  final date = args.value as DateTime;
                  final selectedTimestamp = f.Timestamp.fromDate(
                    DateTime(
                      date.year,
                      date.month,
                      date.day,
                      DateTime.now().hour,
                      DateTime.now().minute,
                    ),
                  );
                  bloc.add(TimestampChanged(timestamp: selectedTimestamp));
                }
              },
            ),
          );

      //Date formatter
      String getFormattedDate(DateTime date) {
        if (date.day == DateTime.now().day) {
          return AppLocalizations.of(context)!.misc_today +
              DateFormat(',').add_jm().format(date);
        } else if (date.day == DateTime.now().subtract(Duration(days: 1)).day) {
          return AppLocalizations.of(context)!.misc_yesterday +
              DateFormat(',').add_jm().format(date);
        } else {
          return DateFormat('MMM d,', AppLocalizations.of(context)!.localeName)
              .add_jm()
              .format(date);
        }
      }

      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!
                  .stats_incomes_recurring_schedule_transaction,
            ),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                FocusScope.of(context).unfocus();
                _showCancelOptions(
                  context,
                  onDiscardPressed: () => AppNavigator.navigateBack(context),
                );
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.misc_save,
                    style: TextStyle(
                      color: state.isSaveEnabled
                          ? Platform.isIOS
                              ? AppColors.primaryColor
                              : AppColors.white
                          : AppColors.greyDisabled,
                    ),
                  ),
                  onPressed: state.isSaveEnabled
                      ? () {
                          bloc.add(
                            ScheduledTransactionSaved(
                              amount: state.transaction.amount,
                            ),
                          );
                          AppNavigator.navigateBack(context);
                        }
                      : null,
                ),
              ),
            ],
          ),
          body: ListView(
            controller: _scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              const SizedBox(height: 25),
              TextField(
                inputFormatters: [formatter],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                autofocus: true,
                textAlign: TextAlign.center,
                cursorColor: AppColors.greyDisabled,
                style: TextStyle(
                  color: state.transaction.isIncome
                      ? AppColors.green
                      : AppColors.red,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: state.transaction.isIncome
                        ? AppColors.green
                        : AppColors.red,
                  ),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: state.transaction.amount.toCurrencyFormat(),
                ),
                onChanged: (amount) => bloc.add(
                  AmountUpdated(
                    amount: amount.isEmpty
                        ? 0.0
                        : double.parse(
                            amount.replaceAll(RegExp(r'[^\w\s]+'), ''),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(height: 2),
              ListTile(
                leading: CircleAvatar(
                  maxRadius: 20,
                  backgroundColor: Color(account.color),
                  backgroundImage: image,
                  child: isImageAvailable ? null : accountIcon,
                ),
                minLeadingWidth: 2,
                title: Text(AppLocalizations.of(context)!.misc_account),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      account.name,
                      style: TextStyle(color: AppColors.greySecondary),
                    ),
                    const SizedBox(width: 10),
                    const Icon(CupertinoIcons.forward)
                  ],
                ),
                onTap: () {
                  AppNavigator
                      .navigateToEditScheduledTransactionSelectAccountPage(
                    context,
                    settingsBloc.state.accounts,
                  );
                },
              ),
              if (state.transaction.isIncome) ...[
                Divider(height: 2),
                ListTile(
                  leading: CircleAvatar(
                    maxRadius: 20,
                    backgroundColor: AppColors.primaryColor,
                    child: Text(
                      state.transaction.incomeType == IncomeType.active
                          ? AppLocalizations.of(context)!.global_incomes_ai
                          : AppLocalizations.of(context)!.global_incomes_pi,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  minLeadingWidth: 2,
                  title: Text(AppLocalizations.of(context)!.misc_type),
                  trailing: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CupertinoSlidingSegmentedControl(
                      children: {
                        0: Text(AppLocalizations.of(context)!.misc_active),
                        1: Text(AppLocalizations.of(context)!.misc_pasive),
                      },
                      onValueChanged: (int? index) {
                        HapticFeedback.selectionClick();
                        bloc.add(IncomeTypeChanged(index: index));
                      },
                      groupValue: state.transaction.incomeType!.index,
                    ),
                  ),
                  onTap: () {
                    AppNavigator
                        .navigateToEditScheduledTransactionSelectAccountPage(
                      context,
                      settingsBloc.state.accounts,
                    );
                  },
                ),
              ],
              Divider(height: 2),
              ListTile(
                leading: state.subCategory.fold(
                  () => CircleAvatar(
                    maxRadius: 20,
                    child: Text(
                      '?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: AppColors.white,
                      ),
                    ),
                    backgroundColor: AppColors.greyDisabled,
                  ),
                  (subCategory) => ListTileLeadingIcon(
                    icon: subCategory.icon,
                    color: subCategory.color,
                  ),
                ),
                title: Text(AppLocalizations.of(context)!.misc_category),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    state.subCategory.fold(
                      () => Text(
                        AppLocalizations.of(context)!.misc_required,
                        style: TextStyle(color: AppColors.red),
                      ),
                      (subCategory) => Text(
                        subCategory.name,
                        style: TextStyle(color: AppColors.greySecondary),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(CupertinoIcons.forward)
                  ],
                ),
                onTap: () => AppNavigator
                    .navigateToEditScheduledTransactionSelectCategoryPage(
                  context,
                ),
              ),
              const Divider(height: 2),
              if (state.transaction.isExpense)
                ListTile(
                  leading: CircleAvatar(
                    maxRadius: 20,
                    backgroundColor: Color(budget.color),
                    child: hasAbbreviation
                        ? Text(
                            budget.abbreviation!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: AppColors.white,
                            ),
                          )
                        : const Icon(
                            Icons.inbox,
                            color: AppColors.white,
                          ),
                  ),
                  minLeadingWidth: 2,
                  title: Text(AppLocalizations.of(context)!.misc_budget),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        budget.name,
                        style: TextStyle(color: AppColors.greySecondary),
                      ),
                      const SizedBox(width: 10),
                      const Icon(CupertinoIcons.forward)
                    ],
                  ),
                  onTap: () {
                    AppNavigator
                        .navigateToEditScheduledTransactionSelectBudgetPage(
                      context,
                      budgets: settingsBloc.state.budgets,
                    );
                  },
                ),
              ListTile(
                leading: const Icon(Icons.drive_file_rename_outline_outlined),
                minLeadingWidth: 2,
                title: Text(AppLocalizations.of(context)!.misc_note),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.transaction.note ?? '',
                      style: TextStyle(color: AppColors.greySecondary),
                    ),
                    const SizedBox(width: 10),
                    const Icon(CupertinoIcons.forward)
                  ],
                ),
                onTap: () {
                  AppNavigator.navigateToEditScheduledTransactionEditNotePage(
                    context,
                    content: state.transaction.note,
                  );
                },
              ),
              Divider(height: 2),
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  leading: const Icon(Icons.calendar_today_rounded),
                  title: Transform.translate(
                    offset: Offset(-20, 0),
                    child: Text(AppLocalizations.of(context)!.misc_from),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        getFormattedDate(state.timestamp.toDate()),
                        style: TextStyle(color: AppColors.greySecondary),
                      ),
                      const SizedBox(width: 10),
                      Transform.rotate(
                        angle: dateArrowTransform,
                        child: const Icon(CupertinoIcons.forward),
                      )
                    ],
                  ),
                  onExpansionChanged: (value) {
                    triggerArrowAnimation(collapsed: value);
                    FocusScope.of(context).unfocus();
                    scrollDown(collapsed: value);
                  },
                  children: [
                    buildDatePicker(),
                  ],
                ),
              ),
              Divider(height: 2),
            ],
          ),
        ),
      );
    }
  }
}

void _showCancelOptions(
  BuildContext context, {
  required VoidCallback onDiscardPressed,
}) {
  showDialog(
    context: context,
    builder: (context) => CustomAlertDialog(
      title: AppLocalizations.of(context)!
          .transactions_edit_transaction_cancel_dialog_title,
      content: AppLocalizations.of(context)!
          .transactions_edit_transaction_cancel_dialog_content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onDiscardPressed();
          },
          child: Text(
            AppLocalizations.of(context)!.misc_discard,
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