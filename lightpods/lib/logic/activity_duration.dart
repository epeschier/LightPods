import 'package:lightpods/models/activity_enums.dart';
import 'package:lightpods/models/activity_result.dart';

import '../models/duration_setting.dart';

abstract class ActivityDuration {
  bool isDone(ActivityResult activityResult, int elapsedTimeInSeconds);
}

class ActivityDurationHits extends ActivityDuration {
  final double maxHits;
  ActivityDurationHits(this.maxHits);

  @override
  bool isDone(ActivityResult activityResult, int elapsedTimeInSeconds) =>
      activityResult.hits >= maxHits;
}

class ActivityDurationTimeout extends ActivityDuration {
  final double maxDurationSec;
  ActivityDurationTimeout(this.maxDurationSec);

  @override
  bool isDone(ActivityResult activityResult, int elapsedTimeInSeconds) =>
      elapsedTimeInSeconds >= maxDurationSec * 60;
}

class ActivityDurationHitsOrTimeout extends ActivityDuration {
  final double maxHits;
  final double maxDuration;

  late ActivityDurationHits _activityDurationHits;
  late ActivityDurationTimeout _activityDurationTimeout;

  ActivityDurationHitsOrTimeout(this.maxHits, this.maxDuration) {
    _activityDurationHits = ActivityDurationHits(maxHits);
    _activityDurationTimeout = ActivityDurationTimeout(maxDuration);
  }

  @override
  bool isDone(ActivityResult activityResult, int elapsedTimeInSeconds) =>
      _activityDurationHits.isDone(activityResult, elapsedTimeInSeconds) ||
      _activityDurationTimeout.isDone(activityResult, elapsedTimeInSeconds);
}

abstract class ActivityDurationFactory {
  static ActivityDuration getActivityDuration(DurationSetting setting) {
    switch (setting.durationType) {
      case ActivityDurationType.numberOfHits:
        return ActivityDurationHits(setting.numberOfHits);
      case ActivityDurationType.timeout:
        return ActivityDurationTimeout(setting.timeout);
      case ActivityDurationType.hitsAndTimeout:
        return ActivityDurationHitsOrTimeout(
            setting.numberOfHits, setting.timeout);
    }
  }
}
