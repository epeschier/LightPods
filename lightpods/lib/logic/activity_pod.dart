import 'dart:async';

import 'package:flutter/material.dart';
import '../models/activity_enums.dart';
import '../models/lights_out_setting.dart';
import 'pod/pod_base.dart';

class ActivityPod {
  final PodBase _pod;
  final LightsOutSetting lightOut;

  ActivityPod(this._pod, this.lightOut) {
    _pod.onHit = _handleHit;
  }

  String get id => _pod.id;

  bool get isActive => _isActive;

  Function? onHitOrTimeout;

  Timer? timer;

  late Color color;

  final Stopwatch _stopwatch = Stopwatch();
  bool _isActive = false;

  void activateWithStoredColor() {
    activate(color);
  }

  void activate(Color color) {
    print("activate $id");
    _isActive = true;
    _pod.setLight(color);
    _stopwatch.reset();
    _stopwatch.start();
    _activateTimer(lightOut.timeout.toInt() * 1000);
  }

  void off() {
    _pod.lightOff();
    _stopwatch.stop();
    _cancelTimer();
    _isActive = false;
  }

  void _activateTimer(int timeoutMs) {
    if (_useTimer()) {
      timer = Timer(Duration(milliseconds: timeoutMs), _onTimerTimeout);
    }
  }

  bool _useTimer() => lightOut.lightsOut != LightsOutType.hit;
  bool _registerHits() => lightOut.lightsOut != LightsOutType.timeout;

  void _onTimerTimeout() {
    _turnOffAndCallback(-1);
  }

  void _cancelTimer() {
    if (_useTimer()) {
      timer?.cancel();
    }
  }

  void _handleHit() {
    _cancelTimer();

    if (_registerHits()) {
      if (_isActive) {
        _turnOffAndCallback(_stopwatch.elapsedMilliseconds);
      } else {
        _isActive = false;
        onHitOrTimeout?.call(-1, this);
      }
    }
  }

  void _turnOffAndCallback(int reactionTime) {
    off();
    _isActive = false;
    onHitOrTimeout?.call(reactionTime, this);
  }
}
