import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lightpods/components/color_indicator.dart';
import 'package:lightpods/theme/theme.dart';

import '../components/list_divider.dart';
import '../components/slider_input.dart';
import '../components/toggle_options.dart';
import '../models/pod_colors.dart';
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

  int index = 0;

  void _sendSettings() {
    var pod = _podService.getPods()[0];
    pod.setLight(PodColorService.distractingColors.getColor(index));
    index++;
    if (index >= PodColorService.distractingColors.getColors.length) {
      index = 0;
    }
    // pod.playEndGame(Colors.green);
  }

  Widget _getSettingsList() => ListView(
        children: [
          _getContainer(
            ColorIndicator(
                colors: PodColorService.hitColors.getColors,
                text: 'Hit Colors'),
          ),
          ListDivider(),
          _getContainer(
            ColorIndicator(
                colors: PodColorService.distractingColors.getColors,
                text: 'Distracting Colors'),
          ),
          ListDivider(),
          _getContainer(SliderInput(
            description: 'Hit Sensitivity',
            value: 10,
            max: 100,
            decimals: 0,
            showValue: true,
          )),
          _getContainer(
            const ToggleOptions(
              values: ['Random', 'All at once'],
              selectedItem: 0,
            ),
          ),
        ],
      );

  Widget _getContainer(Widget w) => Container(
        color: ThemeColors.backgroundColor,
        padding: const EdgeInsets.all(10),
        child: w,
      );
}
