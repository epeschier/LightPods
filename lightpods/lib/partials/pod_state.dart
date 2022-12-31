import 'package:flutter/material.dart';
import 'package:lightpods/components/toggle_button.dart';
import '../logic/pod.dart';

class PodState extends StatefulWidget {
  final Pod pod;

  PodState({super.key, required this.pod}) {}

  @override
  State<PodState> createState() => _PodStateState();
}

class _PodStateState extends State<PodState> {
  var _isConnected = false;

  @override
  Widget build(BuildContext context) {
    widget.pod.onHit = () {
      _onPodHit(context);
    };

    return Container(
        color: const Color.fromARGB(255, 34, 44, 49),
        padding: const EdgeInsets.all(20),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          PodData(pod: widget.pod),
          _lightToggle,
          _bluetoothToggle,
        ]));
  }

  late final ToggleButton _lightToggle = ToggleButton(
    icon: Icons.lightbulb,
    state: true,
    enabled: _isConnected,
    onClick: _onClickLight,
  );

  late final ToggleButton _bluetoothToggle = ToggleButton(
    icon: Icons.bluetooth,
    state: true,
    onClick: _onClickConnect,
  );

  void _onPodHit(BuildContext context) {
    var snackBar = SnackBar(content: Text('Pod ${widget.pod.id} hit'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onClickLight(bool value) {
    if (value) {
      widget.pod.setLight(const Color.fromARGB(255, 255, 4, 4));
    } else {
      widget.pod.lightOff();
    }
  }

  void _onClickConnect(bool value) {
    if (value) {
      widget.pod.initialize();
    } else {
      widget.pod.disconnect();
    }

    setState(() {
      _isConnected = value;
    });
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
