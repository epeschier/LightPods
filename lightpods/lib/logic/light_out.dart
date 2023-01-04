import 'dart:async';

import '../models/activity_enums.dart';
import '../models/activity_setting.dart';
import '../models/lights_out_setting.dart';
import 'callback_wait.dart';

abstract class LightsOut extends CallbackWait {}

class LightsOutHit extends LightsOut {
  @override
  void wait(Function callback) {
    // TODO: subscribe on hit, then turn off
  }
}

class LightsOutTimeout extends LightsOut {
  final int timeoutMs;
  LightsOutTimeout({required this.timeoutMs});

  @override
  void wait(Function callback) {
    Timer(Duration(milliseconds: timeoutMs), () {
      callback();
    });
  }
}

class LightsOutTimeoutOrHit extends LightsOut {
  final int timeoutMs;

  late LightsOutHit _lightsOutHit;
  late LightsOutTimeout _lightsOutTimeout;

  LightsOutTimeoutOrHit({required this.timeoutMs}) {
    _lightsOutHit = LightsOutHit();
    _lightsOutTimeout = LightsOutTimeout(timeoutMs: timeoutMs);
  }

  @override
  void wait(Function callback) {
    // TODO: implement wait on both
  }
}

abstract class LightsOutFactory {
  static LightsOut getLightsOut(LightsOutSetting setting) {
    switch (setting.lightsOut) {
      case LightsOutType.hit:
        return LightsOutHit();
      case LightsOutType.timeout:
        return LightsOutTimeout(timeoutMs: _secToMs(setting.timeout));
      case LightsOutType.hitTimeout:
        return LightsOutTimeoutOrHit(timeoutMs: _secToMs(setting.timeout));
    }
  }

  static int _secToMs(double sec) => (sec * 1000).toInt();
}
