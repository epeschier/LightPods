import 'package:flutter/foundation.dart';
import 'package:lightpods/models/activity_enums.dart';

class ActivitySettingList extends ChangeNotifier {
  final List<ActivitySetting> _list = [];

  void add(ActivitySetting item) {
    _list.add(item);
    notifyListeners();
  }
}

class ActivitySetting {
  late String name = "Workout";

  late int id = -1;

  late int numberOfStations = 1;
  late int numberOfPods = 2;
  late int numberOfPlayers = 1;
  late int numberOfColorsPerPlayer = 1;
  late int numberOfDistractingPods = 0;

  late CompetitionType competitionMode = CompetitionType.regular;

  late DurationSetting activityDuration = DurationSetting();

  late LightsOutSetting lightsOut = LightsOutSetting();

  late LightDelayTimeSetting lightDelayTime = LightDelayTimeSetting();

  late LightupModeType lightupMode = LightupModeType.random;

  ActivitySetting copyWith(ActivitySetting obj) {
    id = obj.id;
    numberOfStations = obj.numberOfStations;
    numberOfPods = obj.numberOfPods;
    numberOfPlayers = obj.numberOfPlayers;
    numberOfColorsPerPlayer = obj.numberOfColorsPerPlayer;
    numberOfDistractingPods = obj.numberOfDistractingPods;
    competitionMode = obj.competitionMode;
    activityDuration = DurationSetting().copyWith(obj.activityDuration);
    lightsOut = LightsOutSetting().copyWith(obj.lightsOut);
    lightDelayTime = LightDelayTimeSetting().copyWith(obj.lightDelayTime);
    lightupMode = obj.lightupMode;

    return this;
  }
}

class DurationSetting {
  late ActivityDurationType durationType = ActivityDurationType.timeout;
  late double numberOfHits = 10;
  late double timeout = 2;

  DurationSetting copyWith(DurationSetting obj) {
    durationType = obj.durationType;
    numberOfHits = obj.numberOfHits;
    timeout = obj.timeout;

    return this;
  }
}

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

class LightsOutSetting {
  late LightsOutType lightsOut = LightsOutType.hit;
  late double timeout = 2;

  LightsOutSetting copyWith(LightsOutSetting value) {
    lightsOut = value.lightsOut;
    timeout = value.timeout;

    return this;
  }
}

/*
Add some validation as some settings do not make sense:
- number of pods <= 2 & LightDelayTimeType.none

*/