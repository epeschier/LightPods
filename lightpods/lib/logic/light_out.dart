import 'dart:async';

import '../models/activity_enums.dart';
import '../models/activity_setting.dart';
import 'callback_wait.dart';

abstract class LightsOut extends CallbackWait {}

class LightsOutHit extends LightsOut {
  @override
  void wait(Function callback) {
    // TODO: subscribe on hit, then turn off
  }
}

class LightsOutTimeout extends LightsOut {
  final int timeout;
  LightsOutTimeout({required this.timeout});

  @override
  void wait(Function callback) {
    Timer(Duration(milliseconds: timeout), () {
      callback();
    });
  }
}

class LightsOutTimeoutOrHit extends LightsOut {
  final int timeout;

  late LightsOutHit _lightsOutHit;
  late LightsOutTimeout _lightsOutTimeout;

  LightsOutTimeoutOrHit({required this.timeout}) {
    _lightsOutHit = LightsOutHit();
    _lightsOutTimeout = LightsOutTimeout(timeout: timeout);
  }

  @override
  void wait(Function callback) {
    // TODO: implement wait on both
  }
}

abstract class LightsOutFactory {
  static LightsOut getLightsOut(ActivitySetting setting) {
    switch (setting.lightsOut) {
      case LightsOutType.hit:
        return LightsOutHit();
      case LightsOutType.timeout:
        return LightsOutTimeout(timeout: setting.lightsOutTimeout);
      case LightsOutType.hitTimeout:
        return LightsOutTimeoutOrHit(timeout: setting.lightsOutTimeout);
    }
  }
}
