import 'package:flutter/material.dart';

class ToggleOptions extends StatefulWidget {
  final List<String> values;
  final Function? onClick;
  final int selectedItem;

  const ToggleOptions(
      {Key? key,
      this.onClick,
      required this.values,
      required this.selectedItem})
      : super(key: key);

  @override
  State createState() => _ToggleOptions();
}

class _ToggleOptions extends State<ToggleOptions> {
  final List<bool> _selectedItems = [];
  final List<Widget> _text = [];

  @override
  void initState() {
    for (var element in widget.values) {
      _text.add(Text(element));
      _selectedItems.add(false);
    }
    _selectedItems[widget.selectedItem] = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        setState(() {
          // The button that is tapped is set to true, and the others to false.
          for (int i = 0; i < _selectedItems.length; i++) {
            _selectedItems[i] = i == index;
          }
        });
        widget.onClick?.call(index);
      },
      isSelected: _selectedItems,
      children: _text,
    );
  }
}
