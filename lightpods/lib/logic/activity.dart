import 'activity_base.dart';

import '../models/activity_enums.dart';
import 'activity_lightup_mode.dart';
import 'activity_pod.dart';
import 'light_delay.dart';
import 'activity_duration.dart';

class Activity extends ActivityBase {
  Activity(setting, activityPods) : super(setting, activityPods) {
    duration =
        ActivityDurationFactory.getActivityDuration(setting.activityDuration);

    lightDelay = LightDelayFactory.getLightDelay(setting.lightDelayTime);
    lightupMode = LightupMode(
        pods: activityPods,
        distractingColors: setting.distractingColors,
        numberOfSimultaneousActivePods: setting.numberOfSimultaneousActivePods,
        hitColors: setting.playerHitColors[0],
        noDuplicate:
            setting.lightDelayTime.delayTimeType == LightDelayTimeType.none);
  }

  late PodsToActivate _activatedPods;

  @override
  void startCycle() {
    print("Start Cycle: wait for next light to turn on");
    lightDelay.wait(_onLightDelayDone);
  }

  void _onLightDelayDone() {
    _activatedPods = lightupMode.getPods();
    _turnOnPods(_activatedPods);
  }

  void _turnOnPods(PodsToActivate pods) {
    for (var p in pods.podsToHit) {
      p.activateWithStoredColor();
    }

    for (var p in pods.distractingPods) {
      p.activateWithStoredColor();
    }
  }

// TODO: change for 2 player
  @override
  void hitHandler(int reactionTime, ActivityPod pod) {
    //print("hit: ${pod.id} in ${reactionTime}");

    var isDistractingPod = lightupMode.isDistractingPod(pod);
    if (reactionTime < 0) {
      if (!isDistractingPod) {
        activityResult.misses++;
      }
    } else {
      // Reaction time >= 0
      if (!isDistractingPod) {
        activityResult.hitReactionTimeInMs.add(reactionTime);
      } else {
        activityResult.misses++;
      }
    }
    onResultChanged?.call(activityResult);

    _checkStartNewCycle();
  }

// TODO: change for 2 player
  void _checkStartNewCycle() {
    if (setting.strikeOut.isStrikeout(activityResult.misses) ||
        duration.isDone(activityResult, elapsedTimeInSeconds)) {
      stop();
    } else {
      _checkEndCycle();
    }
  }

// TODO: change for 2 player
  void _checkEndCycle() {
    if (lightupMode.allCorrectPodsToHitAreHit()) {
      lightupMode.turnOffAllPods();
      startCycle();
    }
  }
}
