import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../resources.dart';

class NoTransactionsWidget extends StatelessWidget {
  final DateTime onDate;

  const NoTransactionsWidget({
    Key? key,
    required this.onDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateString = DateFormat(
      'MMMM - yyyy',
      AppLocalizations.of(context)!.localeName,
    ).format(onDate);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${AppLocalizations.of(context)!.global_no_transactions_message} $dateString',
        style: TextStyle(color: AppColors.greyDisabled),
      ),
    );
  }
}
