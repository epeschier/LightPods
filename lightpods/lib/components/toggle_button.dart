import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ToggleButton extends StatefulWidget {
  final bool state;
  final IconData icon;
  final Function onClick;
  bool? enabled;

  ToggleButton({
    Key? key,
    this.enabled,
    required this.icon,
    required this.state,
    required this.onClick,
  }) : super(key: key);

  @override
  State createState() => _ToggleButton();
}

class _ToggleButton extends State<ToggleButton> {
  Color selectedBackgroundColor = ThemeColors.accentColor;
  Color unSelectedBackgroundColor = ThemeColors.primaryColor;
  Color disabledBackgroundColor = ThemeColors.darkPrimaryColor;

  Color selectedColor = ThemeColors.primaryTextColor;
  Color unSelectedColor = ThemeColors.textIconColor;
  Color disabledColor = ThemeColors.primaryColor;

  bool _state = false;
  void _toggleState() {
    setState(() {
      _state = !_state;
      widget.onClick(_state);
    });
  }

  Color _getBackgroundColor() {
    if (widget.enabled == false) {
      return disabledBackgroundColor;
    }
    return (_state) ? selectedBackgroundColor : unSelectedBackgroundColor;
  }

  Color _getIconColor() {
    if (widget.enabled == false) {
      return disabledColor;
    }
    return (_state) ? selectedColor : unSelectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (widget.enabled == false) ? null : _toggleState,
      style: toggleButtonStyle.copyWith(
        backgroundColor:
            MaterialStateProperty.all<Color>(_getBackgroundColor()),
      ),
      child: Icon(
        widget.icon,
        color: _getIconColor(),
      ),
    );
  }
}
