import 'package:flutter/material.dart';
import 'package:lightpods/components/toggle_button.dart';
import 'package:lightpods/theme/theme.dart';

import '../components/toggle_options.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: _getSettingsList(),
    );
  }

  var _test = true;
  Widget _getSettingsList() => ListView(
        children: [
          _getContainer(
            ThemeColors.backgroundColor,
            const Text('hello'),
          ),
          _getContainer(
              ThemeColors.backgroundColor,
              Row(children: [
                ToggleButton(
                    icon: Icons.abc,
                    state: true,
                    enabled: true,
                    onClick: (state) {
                      setState(() {
                        _test = !_test;
                      });
                    }),
                ToggleButton(
                    icon: Icons.abc,
                    state: false,
                    enabled: true,
                    onClick: (state) {}),
                ToggleButton(
                    icon: Icons.abc,
                    state: true,
                    enabled: _test,
                    onClick: (state) {}),
              ])),
          _getContainer(
            ThemeColors.primaryColor,
            const ToggleOptions(
              values: ['Random', 'All at once'],
              selectedItem: 0,
            ),
          ),
        ],
      );

  Widget _getContainer(Color color, Widget w) => Container(
      height: 80,
      padding: const EdgeInsets.all(10),
      child: Container(
        color: color,
        child: w,
      ));
}
