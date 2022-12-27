import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lightpods/models/activity_pod.dart';
import 'package:lightpods/models/light_delay.dart';
import 'package:lightpods/models/light_out.dart';
import 'package:lightpods/models/pod.dart';

import 'activity_duration.dart';
import 'activity_enums.dart';
import 'activity_result.dart';

class Activity {
  final List<Pod> pods;

  final ActivityDuration activityDurationSetting;
  final LightsOut lightsOut;

  final LightDelayTimeType lightDelayTime;
  int? delayTimeMin;
  int? delayTimeMax;

  final FocusLogic focusLogic;

  final Color colorToHit;

  Activity(
      {this.delayTimeMax,
      this.delayTimeMin,
      required this.activityDurationSetting,
      required this.pods,
      required this.focusLogic,
      required this.colorToHit,
      required this.lightsOut,
      required this.lightDelayTime});

  late List<ActivityPod> _activityPods;
  late ActivityResult activityResult;

  var _random = Random();
  late ActivityPod _podToHit;

  void init() {
    for (var pod in pods) {
      ActivityPod activityPod = ActivityPod(onEnd: _onEnd, pod: pod);
      _activityPods.add(activityPod);
    }
  }

  void run() {
    ActivityDurationBase activityDuration =
        ActivityDurationFactory.getActivityDuration(activityDurationSetting);

    LightDelay lightDelay = LightDelayFactory.getLightDelay(this);

    LightOutRule lightOutRule = LightOutRule(lightsOut: lightsOut);
    var lightOutTimeout = lightOutRule.getTimeout();

    while (!activityDuration.isDone(activityResult)) {
      _clearAllPods();
      lightDelay.wait();

      _podToHit = _activateRandomPod(colorToHit, lightOutTimeout);

      _activateDistractingPods(_podToHit);
    }
  }

  ActivityPod _activateRandomPod(Color color, int timeout) {
    var index = _random.nextInt(_activityPods.length);
    var pod = _activityPods[index];
    pod.activate(colorToHit, timeout);
    return pod;
  }

  void _activateDistractingPods(ActivityPod mainPod) {
    // TODO: activate a number of distracting pods that are not the mainPod.
  }

  void _clearAllPods() {
    for (int i = 0; i < _activityPods.length; i++) {
      _activityPods[i].pod.lightOff();
    }
  }

  void _onEnd(int reactionTime, ActivityPod pod) {
    if ((pod != _podToHit) || (reactionTime <= 0)) {
      activityResult.misses++;
    } else {
      activityResult.hitReactionTimeInMs.add(reactionTime);
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
