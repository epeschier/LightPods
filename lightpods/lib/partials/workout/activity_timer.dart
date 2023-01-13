import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lightpods/components/rounded_icon_button.dart';

class ActivityTimer extends StatefulWidget {
  final Function onStart;
  final Function onStop;
  final Function? onReset;
  late Function? tick;

  ActivityTimer(
      {super.key,
      required this.onStart,
      required this.onStop,
      this.tick,
      this.onReset});

  @override
  State<ActivityTimer> createState() => ActivityTimerState();
}

// TODO: Wakelock.enable();

class ActivityTimerState extends State<ActivityTimer> {
  late Timer _timer;
  String _time = '00 : 00';
  bool _running = false;
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [_getTimeDisplay(), _getButtons()]);
  }

  Widget _getTimeDisplay() => Center(
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            _time,
            style: const TextStyle(fontSize: 80),
          )));

  Widget _getButtons() =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        RoundedIconButton(onClick: _reset, icon: Icons.refresh),
        const SizedBox(
          width: 20,
        ),
        RoundedIconButton(onClick: _onStartStopPressed, icon: _getIcon()),
      ]);

  IconData _getIcon() {
    return _running ? Icons.pause : Icons.play_arrow;
  }

  String _getTime() {
    var mm = (_value / 60).round();
    var ss = _value % 60;
    return '${mm.toString().padLeft(2, '0')} : ${ss.toString().padLeft(2, '0')}';
  }

  void _onStartStopPressed() {
    if (_running) {
      stop();
    } else {
      _start();
    }
  }

  void _start() {
    setState(() {
      _running = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
    widget.onStart();
  }

  void _tick(_) {
    _value++;
    setState(() {
      _time = _getTime();
    });
    widget.tick?.call();
  }

  void stop() {
    setState(() {
      _running = false;
    });
    _timer.cancel();
    widget.onStop();
  }

  void _reset() {
    _value = 0;
    setState(() {
      _time = _getTime();
    });
    widget.onReset?.call();
  }
}
