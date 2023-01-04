import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ActivityDescriptionHeading extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subText;
  final String? value;

  const ActivityDescriptionHeading(
      {super.key,
      required this.icon,
      required this.text,
      this.subText,
      this.value});

  @override
  Widget build(BuildContext context) =>
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.only(right: 10, top: 2),
            child: Icon(
              icon,
              size: 22,
            )),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getHeaderWithValue(),
            Text(
              subText ?? '',
              style: ThemeColors.subText,
            ),
          ],
        ))
      ]);

  Widget _getHeaderWithValue() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: ThemeColors.headerText,
          ),
          Text(
            value ?? '',
            style: ThemeColors.headerValueText,
          ),
        ],
      );
}
