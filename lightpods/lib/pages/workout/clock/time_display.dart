import 'package:flutter/material.dart';
import 'package:lightpods/theme/theme.dart';

import '../../../helper.dart';

class TimeDisplay extends StatelessWidget {
  final int value;

  const TimeDisplay({super.key, required this.value});

  @override
  Widget build(BuildContext context) => _getTimeDisplay();

  Widget _getTimeDisplay() => Text(
        Helper.getTimeMmSsMs(value / 10),
        style: TextStyle(
            fontSize: 70,
            letterSpacing: 1.5,
            color: ThemeColors.lightPrimaryColor),
      );
}
