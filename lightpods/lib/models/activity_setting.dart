import 'package:lightpods/models/activity_enums.dart';

class ActivitySetting {
  late String name = "Workout";

  late int numberOfStations = 1;
  late int numberOfPods;
  late int numberOfPlayers = 1;
  late int numberOfColorsPerPlayer = 1;
  late int numberOfDistractingPods = 0;

  late CompetitionType competitionMode;

  late DurationSetting activityDuration;

  late LightsOutSetting lightsOut;

  late LightDelayTimeSetting lightDelayTime;

  late LightupModeType lightupMode;
}

class DurationSetting {
  late ActivityDurationType durationType;
  late double numberOfHits;
  late double timeout;
}

class LightDelayTimeSetting {
  late LightDelayTimeType delayTimeType;
  late int fixedTime;
  late int randomTimeMin;
  late int randomTimeMax;
}

class LightsOutSetting {
  late LightsOutType lightsOut;
  late int timeout;
}

/*
Add some validation as some settings do not make sense:
- number of pods <= 2 & LightDelayTimeType.none

*/