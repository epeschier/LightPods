import 'package:flutter/material.dart';
import '../models/activity_enums.dart';
import '../models/activity_setting.dart';
import 'activity_lightup_mode.dart';
import 'activity_pod.dart';
import 'light_delay.dart';
import 'activity_duration.dart';
import '../models/activity_result.dart';

class Activity {
  final ActivitySetting setting;
  final List<ActivityPod> activityPods;
  Function? onActivityEnded;
  Function? onResultChanged;

  final ActivityResult _activityResult = ActivityResult();

  late ActivityDuration _duration;
  late LightDelay _lightDelay;
  late LightupMode _lightupMode;

  Activity(this.setting, this.activityPods) {
    _duration =
        ActivityDurationFactory.getActivityDuration(setting.activityDuration);

    _lightDelay = LightDelayFactory.getLightDelay(setting.lightDelayTime);
    _lightupMode = LightupMode(
        pods: activityPods,
        distractingColors: setting.distractingColors,
        numberOfSimultaneousActivePods: setting.numberOfSimultaneousActivePods,
        numberOfHitColors: setting.numberOfHitColors,
        noDuplicate:
            setting.lightDelayTime.delayTimeType == LightDelayTimeType.none);
  }

  late PodsToActivate _activatedPods;

  bool get isRunning => _isRunning;

  bool _isRunning = false;

  void run() {
    _isRunning = true;
    _activityResult.clear();

    _installHitHandlers();

    _startCycle();
  }

  void tick() {
    _activityResult.elapsedTimeInSeconds++;
    if (_duration.isDone(_activityResult)) {
      stop();
    }
  }

  void _startCycle() {
    print("Start Cycle: wait for next light to turn on");
    _lightDelay.wait(_onLightDelayDone);
  }

  void _onLightDelayDone() {
    _activatedPods = _lightupMode.getPods();
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

  void _hitHandler(int reactionTime, ActivityPod pod) {
    //print("hit: ${pod.id} in ${reactionTime}");

    var isDistractingPod = _lightupMode.isDistractingPod(pod);
    if (reactionTime < 0) {
      if (!isDistractingPod) {
        _activityResult.misses++;
      }
    } else {
      // Reaction time >= 0
      if (!isDistractingPod) {
        _activityResult.hitReactionTimeInMs.add(reactionTime);
      } else {
        _activityResult.misses++;
      }
    }
    onResultChanged?.call(_activityResult);

    _checkStartNewCycle();
  }

  void _checkStartNewCycle() {
    if (_isStrikeOut() || _duration.isDone(_activityResult)) {
      stop();
    } else {
      _checkEndCycle();
    }
  }

  void _checkEndCycle() {
    if (_lightupMode.allCorrectPodsToHitAreHit()) {
      _lightupMode.turnOffAllPods();
      _startCycle();
    }
  }

  bool _isStrikeOut() =>
      setting.strikeOut.value &&
      (_activityResult.misses >= setting.strikeOut.count);

  void stop() {
    if (_isRunning) {
      _endActivity();
    }
  }

  void _endActivity() {
    print("activity ended");
    _isRunning = false;

    _lightDelay.abort();
    _uninstallHitHandlers();
    _lightupMode.turnOffAllPods();

    onActivityEnded?.call();
  }

  void _installHitHandlers() {
    for (var p in activityPods) {
      p.onHitOrTimeout = _hitHandler;
    }
  }

  void _uninstallHitHandlers() {
    for (var p in activityPods) {
      p.onHitOrTimeout = null;
    }
  }
}

class FocusLogic {
  final int distractingPods;
  final List<Color> distractingColors;
  final int strikeOut;

  FocusLogic(
      {required this.distractingPods,
      required this.distractingColors,
      required this.strikeOut});
}
