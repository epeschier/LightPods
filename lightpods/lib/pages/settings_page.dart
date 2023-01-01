import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lightpods/components/toggle_button.dart';
import 'package:lightpods/theme/theme.dart';

import '../components/toggle_options.dart';
import '../services/pod_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  final _podService = GetIt.I.get<PodService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: _getSettingsList(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.send_to_mobile),
          onPressed: () {
            _sendSettings();
          }),
    );
  }

  void _sendSettings() {
    // var pod = _podService.getPod('FB:8B:DA:BC:D9:84');
    // pod.playEndGame(Colors.green);
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
