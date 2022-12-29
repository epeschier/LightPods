import 'dart:math';

import 'activity_pod.dart';

import '../models/activity_setting.dart';
import '../models/activity_enums.dart';

abstract class LightupMode {
  final List<ActivityPod> pods;

  LightupMode(this.pods);

  List<ActivityPod> getPodsToTurnOn();
}

class LightupModeRandom extends LightupMode {
  LightupModeRandom(super.pods);

  @override
  List<ActivityPod> getPodsToTurnOn() {
    var pod = _getRandomPod();
    return [pod];
  }

  final _random = Random();

  ActivityPod _getRandomPod() {
    var index = _random.nextInt(pods.length);
    return pods[index];
  }
}

class LightupModeAllAtOnce extends LightupMode {
  LightupModeAllAtOnce(super.pods);

  @override
  List<ActivityPod> getPodsToTurnOn() {
    return pods;
  }
}

abstract class LightupModeFactory {
  static LightupMode getLightupMode(
      ActivitySetting setting, List<ActivityPod> pods) {
    switch (setting.lightupMode) {
      case LightupModeType.random:
        return LightupModeRandom(pods);
      case LightupModeType.allAtOnce:
        return LightupModeAllAtOnce(pods);
    }
  }
}
