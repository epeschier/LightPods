import 'package:flutter/material.dart';

import '../theme/theme.dart';

class PodCount extends StatelessWidget {
  final int count;

  const PodCount({super.key, required this.count});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 20.0, top: 15),
        child: Badge(
            backgroundColor: ThemeColors.accentColor,
            alignment: AlignmentDirectional.topEnd,
            label: Text(count.toStringAsFixed(0),
                style: TextStyle(color: ThemeColors.primaryTextColor)),
            child: Icon(
              size: 30,
              Icons.wb_twighlight,
              color: ThemeColors.primaryColor,
            )),
      );
}
