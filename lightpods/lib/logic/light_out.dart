import '../models/activity_enums.dart';
import '../models/activity_setting.dart';
import 'activity_pod.dart';

abstract class LightsOut {
  late List<ActivityPod> _pods;

  void wait();

  void _turnOffPods() {
    for (int i = 0; i < _pods.length; i++) {
      _pods[i].off();
    }
  }
}

class LightsOutHit extends LightsOut {
  @override
  void wait() {
    // TODO: subscribe on hit, then turn off
  }
}

class LightsOutTimeout extends LightsOut {
  final int timeout;
  LightsOutTimeout({required this.timeout});

  @override
  void wait() async {
    await Future.delayed(Duration(milliseconds: timeout), () {
      _turnOffPods();
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
  void wait() {
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
