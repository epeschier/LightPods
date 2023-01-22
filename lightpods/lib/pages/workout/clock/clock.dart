import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lightpods/components/round_button.dart';
import 'package:lightpods/theme/theme.dart';

import 'rotating_second.dart';
import 'time_display.dart';

class Clock extends StatefulWidget {
  final Function onStart;
  final Function onStop;
  final Function? onReset;
  late Function? tick;
  double startValue;

  Clock(
      {super.key,
      required this.onStart,
      required this.onStop,
      this.tick,
      this.onReset,
      this.startValue = 0});

  @override
  State<Clock> createState() => ClockState();
}

class ClockState extends State<Clock> {
  late Timer? _timer;
  bool _running = false;
  late int _value;
  late int _countDirection = 1;

  final GlobalKey<RotatingSecondState> _rotatingSecond =
      GlobalKey<RotatingSecondState>();

  @override
  void initState() {
    _value = _getStartValue();
    _countDirection = _value == 0 ? 1 : -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [_getTimer(), _getButtons()]);
  }

  int _getStartValue() => (widget.startValue * 10).toInt();

  Widget _getTimer() => Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotatingSecond(
            size: 300.0,
            forward: widget.startValue == 0,
            key: _rotatingSecond,
          ),
          TimeDisplay(value: _value)
        ],
      ));

  Widget _getButtons() =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        RoundButton(
          enabled: _running == false,
          icon: _getIcon(Icons.refresh),
          click: _reset,
        ),
        const SizedBox(
          width: 20,
        ),
        RoundButton(
          click: _onStartStopPressed,
          icon: _getPlayPauseIcon(),
          enabled: true,
        ),
      ]);

  Icon _getPlayPauseIcon() =>
      _getIcon(_running ? Icons.pause : Icons.play_arrow);

  Icon _getIcon(IconData icon) => Icon(
        icon,
        size: 40,
        color: ThemeColors.backgroundColor,
      );

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

    _timer = Timer.periodic(const Duration(milliseconds: 100), _tick);
    widget.onStart();
    _rotatingSecond.currentState?.start();
  }

  void _tick(_) {
    setState(() {
      _value += _countDirection;
    });

    if (_value % 10 == 0) {
      widget.tick?.call();
    }

    if (_countDirection == -1 && _value <= 0) {
      stop();
    }
  }

  void stop() {
    setState(() {
      _running = false;
    });
    _timer?.cancel();
    widget.onStop();
    _rotatingSecond.currentState?.stop();
  }

  void _reset() {
    setState(() {
      _value = _getStartValue();
    });
    widget.onReset?.call();
    _rotatingSecond.currentState?.reset();
  }
}
