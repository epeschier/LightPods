import 'package:flutter/material.dart';

import '../components/bottom_navbar.dart';
import 'general_setup.dart';
import 'device_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  List pages = <Widget>[
    DeviceList(),
    GeneralSetup(),
  ];

  void _updateValue(int value) {
    setState(() {
      _currentPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_currentPage],
        bottomNavigationBar: BottomNavBar(
          click: _updateValue,
        ));
  }
}
