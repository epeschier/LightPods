import 'package:flutter/material.dart';

import '../theme/theme.dart';

class RoundButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? click;
  final bool? enabled;
  const RoundButton({super.key, required this.icon, this.click, this.enabled});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled == true ? click : null,
      style: toggleButtonStyle.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            } else if (states.contains(MaterialState.disabled)) {
              return ThemeColors.buttonDisabledIconColor;
            }
            return ThemeColors.buttonColor; // Use the component's default.
          },
        ),
      ),
      child: icon,
    );
  }
}
