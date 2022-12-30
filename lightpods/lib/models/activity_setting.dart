import 'package:lightpods/models/activity_enums.dart';

class ActivitySetting {
  late int numberOfStations = 1;
  late int numberOfPods;
  late int numberOfPlayers = 1;
  late int numberOfColorsPerPlayer = 1;
  late int numberOfDistractingPods = 0;

  late CompetitionType competitionMode;

  late ActivityDurationType activityDuration;
  late int durationNumberOfHits;
  late int durationTimeout;

  late LightsOutType lightsOut;
  late int lightsOutTimeout;

  late LightDelayTimeType lightDelayTime;
  late int lightDelayFixedTime;
  late int lightDelayRandomTimeMin;
  late int lightDelayRandomTimeMax;

  late LightupModeType lightupMode;
}

/*
Add some validation as some settings do not make sense:
- number of pods <= 2 & LightDelayTimeType.none

*/