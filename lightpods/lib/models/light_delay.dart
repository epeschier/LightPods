import 'dart:math';

import 'package:lightpods/models/activity.dart';

import 'activity_enums.dart';

abstract class LightDelay {
  final Activity activity;
  LightDelay(this.activity);

  void wait() async {}
}

class LightDelayFactory {
  static LightDelay getLightDelay(Activity activity) {
    switch (activity.lightDelayTime) {
      case LightDelayTimeType.none:
        return LightDelayNone(activity);
      case LightDelayTimeType.fixed:
        return LightDelayFixed(activity);
      case LightDelayTimeType.random:
        return LightDelayRandom(activity);
    }
  }
}

class LightDelayNone extends LightDelay {
  LightDelayNone(super.activity);
}

class LightDelayFixed extends LightDelay {
  LightDelayFixed(super.activity);

  @override
  void wait() async {
    await Future.delayed(Duration(seconds: activity.delayTimeMin ?? 0), () {});
  }
}

class LightDelayRandom extends LightDelay {
  LightDelayRandom(super.activity);

  final Random _random = Random();

  @override
  void wait() async {
    var min = activity.delayTimeMin ?? 0;
    var max = activity.delayTimeMax ?? 0;

    var time = min + _random.nextInt(max);
    await Future.delayed(Duration(seconds: time), () {});
  }
}
