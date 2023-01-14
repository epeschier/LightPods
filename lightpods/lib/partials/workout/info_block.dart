import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class InfoBlock extends StatelessWidget {
  final String text;
  final IconData? icon;
  final String description;

  const InfoBlock(
      {super.key, required this.text, this.icon, required this.description});

  @override
  Widget build(BuildContext context) => _info(text, description);

  Widget _info(String text, String subTitle) => Container(
      width: 100,
      height: 80,
      margin: const EdgeInsets.all(8),
      color: ThemeColors.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
              )),
          _descriptionRow(icon, description),
        ],
      ));

  Row _descriptionRow(IconData? icon, String text) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: icon != null,
            child: Icon(
              icon,
              color: ThemeColors.lightPrimaryColor,
            ),
          ),
          const SizedBox(width: 4),
          Text(text,
              style: TextStyle(
                  fontSize: 12, color: ThemeColors.lightPrimaryColor)),
        ],
      );
}
