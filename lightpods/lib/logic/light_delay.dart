import 'dart:async';
import 'dart:math';
import 'package:lightpods/logic/callback_wait.dart';

import '../models/activity_enums.dart';
import '../models/light_delay_time_setting.dart';

abstract class LightDelay extends CallbackWait {
  LightDelay();
}

class LightDelayNone extends LightDelay {
  LightDelayNone();

  @override
  wait(Function callback) => callback();
}

class LightDelayFixed extends LightDelay {
  final int delayTimeMs;

  LightDelayFixed(this.delayTimeMs);

  bool _isWaiting = false;

  @override
  void abort() {
    _isWaiting = false;
    super.abort();
  }

  @override
  void wait(Function callback) {
    if (!_isWaiting) {
      _isWaiting = true;
      timer = Timer(Duration(milliseconds: delayTimeMs), () {
        _isWaiting = false;
        callback();
      });
    }
  }
}

class LightDelayRandom extends LightDelay {
  final int delayTimeMsMin;
  final int delayTimeMsMax;

  LightDelayRandom({
    required this.delayTimeMsMax,
    required this.delayTimeMsMin,
  });

  final Random _random = Random();
  bool _isWaiting = false;

  @override
  void abort() {
    _isWaiting = false;
    super.abort();
  }

  @override
  void wait(Function callback) {
    if (!_isWaiting) {
      _isWaiting = true;
      var time =
          delayTimeMsMin + _random.nextInt(delayTimeMsMax - delayTimeMsMin);
      timer = Timer(Duration(milliseconds: time), () {
        _isWaiting = false;
        callback();
      });
    }
  }
}

abstract class LightDelayFactory {
  static LightDelay getLightDelay(LightDelayTimeSetting setting) {
    switch (setting.delayTimeType) {
      case LightDelayTimeType.none:
        return LightDelayNone();
      case LightDelayTimeType.fixed:
        return LightDelayFixed(_secToMs(setting.fixedTime));
      case LightDelayTimeType.random:
        return LightDelayRandom(
            delayTimeMsMin: _secToMs(setting.randomTimeMin),
            delayTimeMsMax: _secToMs(setting.randomTimeMax));
    }
  }

  static int _secToMs(double sec) => (sec * 1000).toInt();
}
