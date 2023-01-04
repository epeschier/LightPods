import 'activity_enums.dart';

class LightDelayTimeSetting {
  late LightDelayTimeType delayTimeType = LightDelayTimeType.random;
  late double fixedTime = 2;
  late double randomTimeMin = 1;
  late double randomTimeMax = 2;

  LightDelayTimeSetting copyWith(LightDelayTimeSetting obj) {
    delayTimeType = obj.delayTimeType;
    fixedTime = obj.fixedTime;
    randomTimeMin = obj.randomTimeMin;
    randomTimeMax = obj.randomTimeMax;

    return this;
  }
}
