import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../components/toggle_button.dart';
import '../../logic/pod/pod_base.dart';
import '../../services/pod_service.dart';
import 'pod_data.dart';

class PodState extends StatefulWidget {
  final PodBase pod;

  const PodState({super.key, required this.pod});

  @override
  State<PodState> createState() => _PodStateState();
}

class _PodStateState extends State<PodState> {
  final _podService = GetIt.I.get<PodService>();

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
          _getLightToggle(),
          _getBluetoothToggle(),
        ]));
  }

  ToggleButton _getLightToggle() => ToggleButton(
        icon: Icons.lightbulb,
        state: false,
        enabled: widget.pod.isConnected,
        onClick: _onClickLight,
      );

  ToggleButton _getBluetoothToggle() => ToggleButton(
        icon: Icons.bluetooth,
        state: false,
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
        widget.pod.connect();
        _podService.addPod(widget.pod);
      } else {
        widget.pod.disconnect();
        _podService.removePod(widget.pod);
      }
    });
  }
}
