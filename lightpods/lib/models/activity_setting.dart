import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lightpods/models/activity_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'distracting_colors.dart';
import 'duration_setting.dart';
import 'light_delay_time_setting.dart';
import 'lights_out_setting.dart';

part 'activity_setting.g.dart';

@JsonSerializable(explicitToJson: true)
class ActivitySettingList extends ChangeNotifier {
  late List<ActivitySetting> list;

  ActivitySettingList() {
    list = [];
  }

  void add(ActivitySetting item) {
    item.id = list.length + 1;
    list.add(item);
    notifyListeners();
  }

  ActivitySetting getItem(int id) =>
      list.firstWhere((element) => element.id == id);

  factory ActivitySettingList.fromJson(Map<String, dynamic> json) =>
      _$ActivitySettingListFromJson(json);

  Map<String, dynamic> toJson() => _$ActivitySettingListToJson(this);

  static const storageKey = 'activity_settings';

  Future save() async {
    final prefs = await SharedPreferences.getInstance();
    var data = toJson();
    String encodedMap = json.encode(data);
    return prefs.setString(storageKey, encodedMap);
  }

  static Future<ActivitySettingList> load() async {
    var list = ActivitySettingList();
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(storageKey);
    if (data != null) {
      var datamap = json.decode(data!);
      list = ActivitySettingList.fromJson(datamap);
    }

    return list;
  }
}

@JsonSerializable(explicitToJson: true)
class ActivitySetting {
  late String name = "Workout";

  late int id = -1;

  late int numberOfStations = 1;
  late int numberOfPods = 2;
  late int numberOfSimultaneousActivePods = 1;
  late int numberOfPlayers = 1;
  late int numberOfHitColors = 1;
  late int numberOfDistractingColors = 1;

  late StrikeOut strikeOut = StrikeOut();

  late CompetitionType competitionMode = CompetitionType.regular;

  late DurationSetting activityDuration = DurationSetting();

  late LightsOutSetting lightsOut = LightsOutSetting();

  late LightDelayTimeSetting lightDelayTime = LightDelayTimeSetting();

  late DistractingColors distractingColors = DistractingColors();

  ActivitySetting();

  factory ActivitySetting.fromJson(Map<String, dynamic> json) =>
      _$ActivitySettingFromJson(json);

  Map<String, dynamic> toJson() => _$ActivitySettingToJson(this);

  ActivitySetting copyWith(ActivitySetting obj) {
    id = obj.id;
    name = obj.name;
    numberOfStations = obj.numberOfStations;
    numberOfPods = obj.numberOfPods;
    numberOfSimultaneousActivePods = obj.numberOfSimultaneousActivePods;
    numberOfPlayers = obj.numberOfPlayers;
    numberOfHitColors = obj.numberOfHitColors;
    numberOfDistractingColors = obj.numberOfDistractingColors;
    strikeOut = StrikeOut().copyWith(obj.strikeOut);
    competitionMode = obj.competitionMode;
    activityDuration = DurationSetting().copyWith(obj.activityDuration);
    lightsOut = LightsOutSetting().copyWith(obj.lightsOut);
    lightDelayTime = LightDelayTimeSetting().copyWith(obj.lightDelayTime);
    distractingColors = DistractingColors().copyWith(obj.distractingColors);

    return this;
  }

  void sanityCheck() {
    if (lightsOut.lightsOut == LightsOutType.hit) {
      distractingColors.numberOfDistractingColors = 0;
    }
  }
}

@JsonSerializable()
class StrikeOut {
  late bool value = false;
  late int count = 1;

  StrikeOut();

  factory StrikeOut.fromJson(Map<String, dynamic> json) =>
      _$StrikeOutFromJson(json);
  Map<String, dynamic> toJson() => _$StrikeOutToJson(this);

  StrikeOut copyWith(StrikeOut obj) {
    value = obj.value;
    count = obj.count;
    return this;
  }

  @override
  String toString() => (value) ? count.toStringAsFixed(0) : '';
}

/*
Add some validation as some settings do not make sense:
- number of pods <= 2 & LightDelayTimeType.none

Home base Pod color will determine the color the Home Base Pod will light up each time.

Distracting Pods
Colors

*/