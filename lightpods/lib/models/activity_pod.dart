import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lightpods/models/pod.dart';

class ActivityPod {
  final Pod pod;
  final Function onEnd;

  ActivityPod({required this.onEnd, required this.pod}) {
    pod.onHit = _handleHit;
  }

  late Timer _timer;
  bool _isActive = false;

  bool get isActive => _isActive;

  activate(Color color, int timeout) {
    _isActive = true;
    _timer = Timer(Duration(milliseconds: timeout), _handleHit);
    pod.setLight(color);
  }

  void _handleHit() {
    int reactionTime = _timer.tick;
    _timer.cancel();
    pod.lightOff();

    onEnd(reactionTime);
    _isActive = false;
  }
}
