import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ListDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _getDivider();

  Widget _getDivider() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      color: ThemeColors.backgroundColor,
      child: Container(
        color: ThemeColors.secondaryTextColor,
        height: 1,
        width: double.infinity,
      ));
}
