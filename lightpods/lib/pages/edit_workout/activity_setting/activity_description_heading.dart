import 'package:flutter/material.dart';

import '../../../components/header_with_value.dart';
import '../../../theme/theme.dart';

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
            HeaderWithValue(text: text, value: value),
            Text(
              subText ?? '',
              style: ThemeColors.subText,
            ),
          ],
        ))
      ]);
}
