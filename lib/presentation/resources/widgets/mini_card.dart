import 'package:flutter/material.dart';

import '../../../common/extensions.dart';
import '../resources.dart';

class MiniCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final double amount;
  final double opacity;

  const MiniCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor.withOpacity(opacity),
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10 * opacity,
      child: Container(
        padding: EdgeInsets.all(12),
        width: 170,
        height: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.primaryColor.withOpacity(opacity),
              ),
              child: Icon(icon, color: Colors.white.withOpacity(opacity)),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.withOpacity(opacity),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              amount.toCurrencyFormat(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(opacity),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
