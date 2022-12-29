import 'dart:math';
import '../models/activity_enums.dart';
import '../models/activity_setting.dart';

abstract class LightDelay {
  LightDelay();

  Future wait(Function callback);
}

class LightDelayNone extends LightDelay {
  LightDelayNone();

  @override
  Future wait(Function callback) =>
      Future.delayed(const Duration(seconds: 0), () {
        callback();
      });
}

class LightDelayFixed extends LightDelay {
  final int delayTime;

  LightDelayFixed(this.delayTime);

  @override
  Future wait(Function callback) =>
      Future.delayed(Duration(milliseconds: delayTime), () {
        callback();
      });
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
  Future wait(Function callback) {
    var time = delayTimeMin + _random.nextInt(delayTimeMax);
    return Future.delayed(Duration(seconds: time), () {
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
