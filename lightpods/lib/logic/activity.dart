import 'package:flutter/material.dart';
import 'package:lightpods/models/activity_enums.dart';
import 'package:lightpods/models/activity_setting.dart';
import 'activity_lightup_mode.dart';
import 'activity_pod.dart';
import 'light_delay.dart';
import 'light_out.dart';
import 'activity_duration.dart';
import '../models/activity_result.dart';

class Activity {
  final ActivitySetting setting;
  final List<ActivityPod> activityPods;
  Function? onActivityEnded;
  Function? onResultChanged;

  final ActivityResult _activityResult = ActivityResult();

  late ActivityDuration _duration;
  late LightsOut _lightsOut;
  late LightDelay _lightDelay;
  late LightupMode _lightupMode;

  Activity(this.setting, this.activityPods) {
    _duration =
        ActivityDurationFactory.getActivityDuration(setting.activityDuration);

    _lightsOut = LightsOutFactory.getLightsOut(setting.lightsOut);
    _lightDelay = LightDelayFactory.getLightDelay(setting.lightDelayTime);
    _lightupMode = LightupMode(
        activityPods, setting.numberOfDistractingPods, setting.numberOfPods);
  }

  late PodsToActivate _activatedPods;

  bool _isRunning = false;

  void run() {
    _isRunning = true;
    _activityResult.clear();

    _lightupMode.installHitHandlers(_hitHandler);

    _startCycle();
  }

  void tick() {
    _activityResult.elapsedTimeInSeconds++;
    _checkForActivityEnd();
  }

  void _startCycle() {
    print("Start Cycle: wait for next light to turn on");
    _lightDelay.wait(_onLightDelayDone);
  }

  void _onLightDelayDone() {
    _activatedPods = _lightupMode.getPods();
    _turnOnPods(_activatedPods);

    _lightsOut.wait(_lightsOutHandler);
  }

  void _turnOnPods(PodsToActivate pods) {
    for (var p in pods.podsToHit) {
      p.activate(_getHitColor());
    }

    for (var p in pods.distractingPods) {
      p.activate(_getDistractingColor());
    }
  }

  void _lightsOutHandler() {
    print("lights out after timeout");
    _registerMissedPods(_activatedPods.podsToHit);
    _lightupMode.turnOffAllPods();

    _checkForActivityEnd();
  }

  void _registerMissedPods(List<ActivityPod> pods) {
    for (var p in pods) {
      if (p.isActive) {
        _activityResult.misses++;
      }
    }
  }

// TODO: get random colors for hit and distraction.
  Color _getHitColor() {
    return Colors.red;
  }

  Color _getDistractingColor() {
    return Colors.yellow;
  }

  void _hitHandler(int reactionTime, ActivityPod pod) {
    print("hit: ${pod.id} in ${reactionTime}");

    if (_lightupMode.isDistractingPod(pod)) {
      _activityResult.misses++;
    } else {
      if (reactionTime > 0) {
        _activityResult.hitReactionTimeInMs.add(reactionTime);
      } else {
        _activityResult.misses++;
      }
    }
    onResultChanged?.call(_activityResult);
    _checkEndCycle();
    _checkForActivityEnd();
  }

  void _checkEndCycle() {
    if (_lightupMode.allPodsToHitAreHit()) {
      _lightsOut.abort();
      _lightupMode.turnOffAllPods();

      _startCycle();
    }
  }

  void _checkForActivityEnd() {
    if (_isStrikeOut() || _duration.isDone(_activityResult)) {
      stop();
      _lightupMode.turnOffAllPods();
    }
  }

  bool _isStrikeOut() =>
      setting.strikeOut.value &&
      (_activityResult.misses >= setting.strikeOut.count);

  void stop() {
    if (_isRunning) {
      print("activity ended");
      _isRunning = false;

      _lightsOut.abort();
      _lightDelay.abort();
      _lightupMode.uninstallHitHandlers();
      _lightupMode.turnOffAllPods();

      onActivityEnded?.call();
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
