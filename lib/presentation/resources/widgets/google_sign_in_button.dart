import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../resources.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: _isDarkMode ? AppColors.greyPrimary : AppColors.white,
        elevation: 8,
        minimumSize: Size(240, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/google_icon.png'),
            backgroundColor:
                _isDarkMode ? AppColors.greyPrimary : AppColors.white,
          ),
          const SizedBox(width: 8),
          Text(
            AppLocalizations.of(context)!.widgets_google_sign_in_button,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ],
      ),
    );
  }
}
