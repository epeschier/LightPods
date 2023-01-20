import 'package:flutter/material.dart';
import '../../components/toggle_button.dart';
import '../../logic/pod/pod_base.dart';
import 'pod_data.dart';

class PodState extends StatefulWidget {
  final PodBase pod;

  const PodState({super.key, required this.pod});

  @override
  State<PodState> createState() => _PodStateState();
}

class _PodStateState extends State<PodState> {
  bool _canTurnOnLight = false;

  @override
  void initState() {
    widget.pod.onHit = () {
      _onPodHit(context);
    };
    print("##### ${widget.pod.name} ${widget.pod.isConnected}");
    _canTurnOnLight = widget.pod.isConnected;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 34, 44, 49),
        padding: const EdgeInsets.all(20),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          PodData(pod: widget.pod),
          _getLightToggle(),
          _getBluetoothToggle(),
        ]));
  }

  ToggleButton _getLightToggle() => ToggleButton(
        icon: Icons.lightbulb,
        state: false,
        enabled: _canTurnOnLight,
        onClick: _onClickLight,
      );

  ToggleButton _getBluetoothToggle() => ToggleButton(
        icon: Icons.bluetooth,
        state: widget.pod.isConnected,
        onClick: _onClickConnect,
      );

  void _onPodHit(BuildContext context) {
    var snackBar = SnackBar(content: Text('Pod ${widget.pod.id} hit'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onClickLight(bool value) {
    if (value) {
      widget.pod.setLight(const Color.fromARGB(255, 255, 0, 0));
    } else {
      widget.pod.lightOff();
    }
  }

  void _onClickConnect(bool value) {
    setState(() {
      if (value) {
        widget.pod.onConnectionChanged = _updateConnectionState;
        widget.pod.connect();
      } else {
        widget.pod.disconnect();
      }
    });
  }

  void _updateConnectionState(bool connected) {
    setState(() {
      print("### update state: $connected");
      _canTurnOnLight = connected;
    });
  }
}
