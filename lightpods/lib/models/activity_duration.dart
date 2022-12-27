import 'package:lightpods/models/activity_enums.dart';
import 'package:lightpods/models/activity_result.dart';

import 'activity.dart';

class ActivityDuration {
  final ActivityDurationType activityDurationType;
  int? maxHits;
  int? maxDuration;

  ActivityDuration(this.activityDurationType);
}

abstract class ActivityDurationBase {
  final ActivityDuration activityDuration;
  ActivityDurationBase(this.activityDuration);

  bool isDone(ActivityResult activityResult);

  bool hasMaxHits(int hits) {
    return hits > (activityDuration.maxHits ?? 0);
  }

  bool hasMaxTime(int time) {
    return time > (activityDuration.maxDuration ?? 0);
  }
}

class ActivityDurationFactory {
  static ActivityDurationBase getActivityDuration(
      ActivityDuration activityDuration) {
    switch (activityDuration.activityDurationType) {
      case ActivityDurationType.hitTimeout:
        return ActivityDurationHitsOrTimeout(activityDuration);
      case ActivityDurationType.numberOfHits:
        return ActivityDurationHits(activityDuration);
      case ActivityDurationType.timeout:
        return ActivityDurationTimeout(activityDuration);
    }
  }
}

class ActivityDurationHits extends ActivityDurationBase {
  ActivityDurationHits(ActivityDuration activityDuration)
      : super(activityDuration);

  @override
  bool isDone(ActivityResult activityResult) => hasMaxHits(activityResult.hits);
}

class ActivityDurationTimeout extends ActivityDurationBase {
  ActivityDurationTimeout(ActivityDuration activityDuration)
      : super(activityDuration);

  @override
  bool isDone(ActivityResult activityResult) =>
      hasMaxTime(activityResult.elapsedTimeInSeconds);
}

class ActivityDurationHitsOrTimeout extends ActivityDurationBase {
  ActivityDurationHitsOrTimeout(ActivityDuration activityDuration)
      : super(activityDuration);

  @override
  bool isDone(ActivityResult activityResult) =>
      hasMaxHits(activityResult.hits) ||
      hasMaxTime(activityResult.elapsedTimeInSeconds);
}
