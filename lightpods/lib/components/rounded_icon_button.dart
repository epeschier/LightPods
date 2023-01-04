import 'package:flutter/material.dart';
import 'package:lightpods/theme/theme.dart';

class RoundedIconButton extends StatelessWidget {
  final VoidCallback onClick;
  final IconData icon;

  const RoundedIconButton(
      {super.key, required this.onClick, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: ThemeColors.buttonColor,
        foregroundColor: ThemeColors.backgroundColor,
      ),
      child: Icon(icon, size: 50),
    );
  }
}
