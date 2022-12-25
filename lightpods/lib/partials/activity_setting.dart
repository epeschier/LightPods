import 'package:flutter/material.dart';

import '../theme/theme.dart';

class ActivitySetting extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subText;
  final Widget widget;

  const ActivitySetting(
      {super.key,
      required this.icon,
      required this.text,
      required this.widget,
      this.subText});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 80,
      decoration: BoxDecoration(
        color: ThemeColors.backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                icon,
                size: 40,
              )),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  letterSpacing: 0.5,
                  fontSize: 20,
                ),
              ),
              Text(
                subText ?? '',
                style: ThemeColors.subText,
              ),
            ],
          )),
          widget,
        ],
      ),
    );
  }
}
