import 'package:flutter/material.dart';
import 'pod/pod_base.dart';

class ActivityPod {
  final PodBase _pod;

  ActivityPod(this._pod) {
    _pod.onHit = _handleHit;
  }

  String get id => _pod.id;

  bool get isActive => _isActive;

  Function? onHitOrTimeout;

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
  }

  void off() {
    _pod.lightOff();
    _stopwatch.stop();
    _isActive = false;
  }

  void _handleHit() {
    if (_isActive) {
      // TODO: check if keep on
      off();
      _isActive = false;
      onHitOrTimeout?.call(_stopwatch.elapsedMilliseconds, this);
    } else {
      _isActive = false;
      onHitOrTimeout?.call(-1, this);
    }
  }
}
