import 'package:flutter/material.dart';
import 'package:lightpods/components/toggle_button.dart';
import '../models/pod.dart';

class PodState extends StatelessWidget {
  final Pod pod;

  const PodState({super.key, required this.pod});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 34, 44, 49),
        padding: const EdgeInsets.all(20),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          PodData(pod: pod),
          const LightToggle(),
          const BlueToothToggle(),
        ]));
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

class LightToggle extends StatelessWidget {
  const LightToggle({super.key});

  void _toggleLight(bool value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButton(
      icon: Icons.lightbulb,
      state: true,
      onClick: (value) {
        _toggleLight(value);
      },
    );
  }
}

class BlueToothToggle extends StatelessWidget {
  const BlueToothToggle({super.key});

  void _connect(bool value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButton(
      icon: Icons.bluetooth,
      state: true,
      onClick: (value) {
        _connect(value);
      },
    );
  }
}
