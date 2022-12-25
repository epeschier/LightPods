import 'package:flutter/material.dart';
import 'package:lightpods/components/toggle_button.dart';
import '../models/pod.dart';

class PodState extends StatelessWidget {
  final Pod pod;

  PodState({super.key, required this.pod});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 34, 44, 49),
        padding: const EdgeInsets.all(20),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          PodData(pod: pod),
          _lightToggle,
          _bluetoothToggle,
        ]));
  }

  late final ToggleButton _lightToggle = ToggleButton(
    icon: Icons.lightbulb,
    state: true,
    onClick: _onClickLight,
  );

  late final ToggleButton _bluetoothToggle = ToggleButton(
    icon: Icons.bluetooth,
    state: true,
    onClick: _onClickConnect,
  );

  void _onClickLight(bool value) {
    if (value) {
      pod.setLight(const Color.fromARGB(255, 255, 4, 4));
    } else {
      pod.lightOff();
    }
  }

  void _onClickConnect(bool value) {
    if (value) {
      pod.initialize();
    } else {
      pod.disconnect();
    }
  }
}

class PodData extends StatelessWidget {
  final Pod pod;

  const PodData({super.key, required this.pod});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pod.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(pod.id),
      ],
    ));
  }
}
