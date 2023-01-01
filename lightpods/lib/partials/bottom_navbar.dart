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
    return BottomNavigationBar(
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
          label: 'Workout definition',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.alarm_on),
          label: 'Workout',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
