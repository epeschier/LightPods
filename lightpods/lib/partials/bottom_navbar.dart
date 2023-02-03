import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final Function click;
  const BottomNavBar({Key? key, required this.click}) : super(key: key);

  @override
  State createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 0;

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
      widget.click(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getContainerWithShadow(BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 30,
      currentIndex: _index,
      onTap: (_onItemTapped),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_bluetooth),
          label: 'Connections',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Workout list',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    ));
  }

  Widget _getContainerWithShadow(Widget child) => Container(
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75))
        ],
      ),
      child: child);
}
