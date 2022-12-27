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

  activate(Color color, int timeout) {
    _isActive = true;
    _timer = Timer(Duration(milliseconds: timeout), _handleTimeout);
    pod.setLight(color);
  }

  void _handleHit() {
    if (_isActive) {
      int reactionTime = _timer.tick;
      _timer.cancel();

      pod.lightOff();

      onEnd(reactionTime, this);
    } else {
      onEnd(-1, this);
    }
    _isActive = false;
  }

  void _handleTimeout() {
    pod.lightOff();
    _isActive = false;
    onEnd(-1, this);
  }
}
