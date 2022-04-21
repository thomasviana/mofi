import 'package:flutter/material.dart';

import '../resources.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(60),
      contentPadding: EdgeInsets.only(
        top: 16,
        left: 8,
        right: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30.0,
                left: 8.0,
                right: 8.0,
              ),
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.greySecondary),
              ),
            ),
            const Divider(height: 0.0),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => actions[index],
              separatorBuilder: (context, index) => const Divider(height: 0.0),
              itemCount: actions.length,
            )
          ],
        ),
      ),
    );
  }
}
