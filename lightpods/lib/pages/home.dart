import 'package:flutter/material.dart';
import 'package:lightpods/pages/activity_list_page.dart';
import 'package:lightpods/pages/settings_page.dart';

import '../partials/bottom_navbar.dart';
import 'device_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  List pages = const <Widget>[DeviceList(), ActivityListPage(), SettingsPage()];

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
