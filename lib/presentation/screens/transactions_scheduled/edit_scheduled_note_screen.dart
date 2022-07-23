import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/colors.dart';
import '../../routes/app_navigator.dart';
import 'edit_scheduled_transaction_bloc/edit_scheduled_transaction_screen_bloc.dart';

class EditScheduledNoteScreen extends StatefulWidget {
  final String content;
  const EditScheduledNoteScreen({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  State<EditScheduledNoteScreen> createState() =>
      _EditScheduledNoteScreenState();
}

class _EditScheduledNoteScreenState extends State<EditScheduledNoteScreen> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController()..text = widget.content;
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.misc_note),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text(
                AppLocalizations.of(context)!.misc_done,
                style: TextStyle(
                  color:
                      Platform.isIOS ? AppColors.primaryColor : AppColors.white,
                ),
              ),
              onPressed: () {
                context
                    .read<EditScheduledTransactionScreenBloc>()
                    .add(NoteUpdated(note: textEditingController.text.trim()));
                AppNavigator.navigateBack(context);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          TextField(
            controller: textEditingController,
            keyboardType: TextInputType.name,
            autofocus: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              alignLabelWithHint: true,
              label: Center(
                child: Text(
                  AppLocalizations.of(context)!.transactions_edit_note_add_note,
                ),
              ),
              labelStyle: TextStyle(
                color: AppColors.greyDisabled,
                fontWeight: FontWeight.w300,
              ),
              hintStyle: TextStyle(fontSize: 18),
              border: InputBorder.none,
            ),
          )
        ],
      ),
    );
  }
}
