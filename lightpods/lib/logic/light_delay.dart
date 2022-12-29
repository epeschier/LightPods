import 'dart:async';
import 'dart:math';
import 'package:lightpods/logic/callback_wait.dart';

import '../models/activity_enums.dart';
import '../models/activity_setting.dart';

abstract class LightDelay extends CallbackWait {
  LightDelay();
}

class LightDelayNone extends LightDelay {
  LightDelayNone();

  @override
  wait(Function callback) => callback();
}

class LightDelayFixed extends LightDelay {
  final int delayTime;

  LightDelayFixed(this.delayTime);

  @override
  void wait(Function callback) {
    timer = Timer(Duration(milliseconds: delayTime), () {
      callback();
    });
  }
}

class LightDelayRandom extends LightDelay {
  final int delayTimeMin;
  final int delayTimeMax;

  LightDelayRandom({
    required this.delayTimeMax,
    required this.delayTimeMin,
  });

  final Random _random = Random();

  @override
  void wait(Function callback) {
    var time = delayTimeMin + _random.nextInt(delayTimeMax);
    timer = Timer(Duration(seconds: time), () {
      callback();
    });
  }
}

abstract class LightDelayFactory {
  static LightDelay getLightDelay(ActivitySetting setting) {
    switch (setting.lightDelayTime) {
      case LightDelayTimeType.none:
        return LightDelayNone();
      case LightDelayTimeType.fixed:
        return LightDelayFixed(setting.lightDelayFixedTime);
      case LightDelayTimeType.random:
        return LightDelayRandom(
            delayTimeMin: setting.lightDelayRandomTimeMin,
            delayTimeMax: setting.lightDelayRandomTimeMax);
    }
  }
}
