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

  bool get isActive => _pod.isOn;

  Function? onHitOrTimeout;

  Timer? timer;

  late Color color;

  final Stopwatch _stopwatch = Stopwatch();

  void activateWithStoredColor() {
    activate(color);
  }

  void activate(Color color) {
    print("activate $id");
    _pod.setLight(color);
    _stopwatch.reset();
    _stopwatch.start();
    _activateTimer(lightOut.timeout.toInt() * 1000);
  }

  void off() {
    _pod.lightOff();
    _stopwatch.stop();
    _cancelTimer();
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
      if (isActive) {
        _turnOffAndCallback(_stopwatch.elapsedMilliseconds);
      } else {
        onHitOrTimeout?.call(-1, this);
      }
    }
  }

  void _turnOffAndCallback(int reactionTime) {
    off();
    onHitOrTimeout?.call(reactionTime, this);
  }

  late Timer _blinkTimer;
  void blink(int intervalMs, Color color) {
    _blinkTimer = Timer.periodic(Duration(milliseconds: intervalMs), (timer) {
      if (_pod.isOn) {
        _pod.lightOff();
      } else {
        _pod.setLight(color);
      }
    });
  }

  void stopBlink() {
    _blinkTimer.cancel();
    _pod.lightOff();
  }
}
