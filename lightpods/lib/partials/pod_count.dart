import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

class PodCount extends StatelessWidget {
  final int count;

  const PodCount({super.key, required this.count});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 20.0, top: 5),
        child: Badge(
            badgeColor: ThemeColors.accentColor,
            badgeContent: Text(count.toStringAsFixed(0),
                style: TextStyle(color: ThemeColors.primaryTextColor)),
            child: Icon(
              size: 30,
              Icons.wb_twighlight,
              color: ThemeColors.primaryColor,
            )),
      );
}
