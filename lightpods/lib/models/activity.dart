import 'package:flutter/material.dart';
import 'package:lightpods/models/activity_pod.dart';
import 'package:lightpods/models/pod.dart';

import 'activity_enums.dart';

class Activity {
  final List<Pod> pods;
  final ActivityDuration activityDuration;
  final LightsOut lightsOut;
  final LightDelayTime delayTime;
  final FocusLogic focusLogic;

  final Color colorToHit;

  Activity(
      {required this.activityDuration,
      required this.pods,
      required this.focusLogic,
      required this.colorToHit,
      required this.lightsOut,
      required this.delayTime});

  late List<ActivityPod> _activityPods;

  void init() {
    for (var pod in pods) {
      ActivityPod activityPod = ActivityPod(onEnd: _onEnd, pod: pod);
      _activityPods.add(activityPod);
    }
  }

  void run() {}

  void _onEnd(int reactionTime) {}
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
