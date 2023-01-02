import 'package:lightpods/models/activity_enums.dart';
import 'package:lightpods/models/activity_result.dart';
import 'package:lightpods/models/activity_setting.dart';

abstract class ActivityDuration {
  bool isDone(ActivityResult activityResult);
}

class ActivityDurationHits extends ActivityDuration {
  final double maxHits;
  ActivityDurationHits(this.maxHits);

  @override
  bool isDone(ActivityResult activityResult) =>
      _hasMaxHits(activityResult.hits);

  bool _hasMaxHits(int hits) {
    return hits >= (maxHits);
  }
}

class ActivityDurationTimeout extends ActivityDuration {
  final double maxDuration;
  ActivityDurationTimeout(this.maxDuration);

  @override
  bool isDone(ActivityResult activityResult) =>
      _hasMaxTime(activityResult.elapsedTimeInSeconds);

  bool _hasMaxTime(int time) {
    return time >= (maxDuration);
  }
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
  bool isDone(ActivityResult activityResult) =>
      _activityDurationHits.isDone(activityResult) ||
      _activityDurationTimeout.isDone(activityResult);
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
