import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lightpods/components/rounded_icon_button.dart';
import 'package:lightpods/theme/theme.dart';

class ActivityTimer extends StatefulWidget {
  final Function onStart;
  final Function onStop;
  const ActivityTimer({super.key, required this.onStart, required this.onStop});

  @override
  State<ActivityTimer> createState() => _ActivityTimerState();
}

// TODO: Wakelock.enable();

class _ActivityTimerState extends State<ActivityTimer> {
  late Timer _timer;
  String _time = '00 : 00';
  bool _running = false;
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [_getTimeDisplay(), _getButtons(), _infoCards()]);
  }

  Widget _getTimeDisplay() => Center(
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            _time,
            style: const TextStyle(fontSize: 120),
          )));

  Widget _getButtons() =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        RoundedIconButton(onClick: _reset, icon: Icons.refresh),
        RoundedIconButton(onClick: _onStartStopPressed, icon: _getIcon()),
      ]);

  Widget _infoCards() => Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          info('2', 'Miss'),
          info('11', 'Hits'),
          info('717', 'Avg. Reaction')
        ],
      ));

  Widget info(String text, String subTitle) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(10),
            color: ThemeColors.darkPrimaryColor,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text, style: const TextStyle(fontSize: 40)),
                Text(subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, color: ThemeColors.secondaryTextColor)),
              ],
            )));
  }

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
      _stop();
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
  }

  void _stop() {
    setState(() {
      _running = false;
    });
    _timer.cancel();
    widget.onStop();
  }

  void _reset() {
    setState(() {
      _value = 0;
    });
    _timer.cancel();
  }
}
