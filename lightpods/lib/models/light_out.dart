import 'dart:math';

import 'package:lightpods/models/activity_enums.dart';

class LightsOut {
  final LightsOutType lightsOutType;
  int? timeoutMin;
  int? timeoutMax;

  LightsOut({required this.lightsOutType});

  final _random = Random();

  int getTimeoutTime() {
    if (timeoutMin != null && timeoutMax != null) {
      var diff = timeoutMax! - timeoutMin!;
      return timeoutMin! + _random.nextInt(diff);
    }
    return timeoutMin ?? timeoutMax ?? 0;
  }
}

class LightOutRule {
  final LightsOut lightsOut;

  LightOutRule({required this.lightsOut});

  static const int _maxTimeout = 1000;

  int getTimeout() {
    if (lightsOut.lightsOutType == LightsOutType.hit) {
      return _maxTimeout;
    } else {
      return lightsOut.getTimeoutTime();
    }
  }

  void wait() async {
    var timeout = lightsOut.getTimeoutTime();
    await Future.delayed(Duration(seconds: timeout), () {});
  }
}
