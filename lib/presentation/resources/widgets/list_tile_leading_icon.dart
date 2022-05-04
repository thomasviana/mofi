import 'package:flutter/material.dart';

import '../colors.dart';

class ListTileLeadingIcon extends StatelessWidget {
  final int icon;
  final int color;

  const ListTileLeadingIcon({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return CircleAvatar(
      backgroundColor: Color(color),
      radius: 20,
      child: CircleAvatar(
        backgroundColor: _isDarkMode ? AppColors.greyPrimary : AppColors.white,
        radius: 18,
        child: Icon(
          IconData(
            icon,
            fontFamily: 'MaterialIcons',
          ),
          color: Color(color),
        ),
      ),
    );
  }
}
