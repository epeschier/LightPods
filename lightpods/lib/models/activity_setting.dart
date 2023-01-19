import 'package:json_annotation/json_annotation.dart';
import 'package:lightpods/models/activity_enums.dart';

import 'distracting_colors.dart';
import 'duration_setting.dart';
import 'light_delay_time_setting.dart';
import 'lights_out_setting.dart';
import 'strike_out.dart';

part 'activity_setting.g.dart';

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

/*
Add some validation as some settings do not make sense:
- number of pods <= 2 & LightDelayTimeType.none

Home base Pod color will determine the color the Home Base Pod will light up each time.

Distracting Pods
Colors

*/