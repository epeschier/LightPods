import 'package:flutter/material.dart';
import 'package:lightpods/models/activity_enums.dart';

import '../partials/activity_timer.dart';
import '../models/activity.dart';
import '../models/pod.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Activity'),
        ),
        body: Column(children: const [
          ActivityTimer(),
        ]));
  }

  Activity createActivity() {
    List<Pod> pods = <Pod>[];
    List<Color> distractingColors = <Color>[Colors.green, Colors.yellow];

    FocusLogic focusLogic = FocusLogic(
        distractingPods: 0, distractingColors: distractingColors, strikeOut: 2);

    Activity activity = Activity(
        pods: pods,
        colorToHit: Colors.blue,
        activityDuration: ActivityDuration.numberOfHits,
        lightsOut: LightsOut.hit,
        lightDelayTime: LightDelayTime.random,
        delayTime: 0,
        focusLogic: focusLogic);

    return activity;
  }
}
