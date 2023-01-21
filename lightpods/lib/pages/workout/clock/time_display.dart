import 'package:flutter/material.dart';
import 'package:lightpods/theme/theme.dart';

class TimeDisplay extends StatelessWidget {
  final int value;

  const TimeDisplay({super.key, required this.value});

  @override
  Widget build(BuildContext context) => _getTimeDisplay();

  Widget _getTimeDisplay() => Text(
        _getTime(value),
        style: TextStyle(
            fontSize: 70,
            letterSpacing: 1.5,
            color: ThemeColors.lightPrimaryColor),
      );

  String _getTime(int value) {
    var ms = value % 10;
    var sec = (value / 10).truncate();
    var mm = (sec / 60).round();
    var ss = sec % 60;
    return '${mm.toString().padLeft(2, '0')}:${ss.toString().padLeft(2, '0')}.${ms.toString()}';
  }
}
