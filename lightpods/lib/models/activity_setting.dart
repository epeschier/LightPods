import 'package:flutter/foundation.dart';
import 'package:lightpods/models/activity_enums.dart';

import 'duration_setting.dart';
import 'light_delay_time_setting.dart';
import 'lights_out_setting.dart';

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
  late int numberOfSimultaneousActivePods = 1;
  late int numberOfPlayers = 1;
  late int numberOfColorsPerPlayer = 1;
  late int numberOfDistractingPods = 0;

  late StrikeOut strikeOut = StrikeOut();

  late CompetitionType competitionMode = CompetitionType.regular;

  late DurationSetting activityDuration = DurationSetting();

  late LightsOutSetting lightsOut = LightsOutSetting();

  late LightDelayTimeSetting lightDelayTime = LightDelayTimeSetting();

  ActivitySetting copyWith(ActivitySetting obj) {
    id = obj.id;
    name = obj.name;
    numberOfStations = obj.numberOfStations;
    numberOfPods = obj.numberOfPods;
    numberOfSimultaneousActivePods = obj.numberOfSimultaneousActivePods;
    numberOfPlayers = obj.numberOfPlayers;
    numberOfColorsPerPlayer = obj.numberOfColorsPerPlayer;
    numberOfDistractingPods = obj.numberOfDistractingPods;
    strikeOut = StrikeOut().copyWith(obj.strikeOut);
    competitionMode = obj.competitionMode;
    activityDuration = DurationSetting().copyWith(obj.activityDuration);
    lightsOut = LightsOutSetting().copyWith(obj.lightsOut);
    lightDelayTime = LightDelayTimeSetting().copyWith(obj.lightDelayTime);

    return this;
  }
}

class StrikeOut {
  late bool value = false;
  late int count = 1;

  StrikeOut copyWith(StrikeOut obj) {
    value = obj.value;
    count = obj.count;
    return this;
  }
}

/*
Add some validation as some settings do not make sense:
- number of pods <= 2 & LightDelayTimeType.none

Home base Pod color will determine the color the Home Base Pod will light up each time.

Distracting Pods
Colors

*/