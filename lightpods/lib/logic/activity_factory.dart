import 'package:flutter/material.dart';
import 'package:lightpods/logic/activity_lightup_mode.dart';

import 'activity.dart';
import 'activity_duration.dart';
import 'activity_pod.dart';
import '../models/activity_setting.dart';
import 'light_delay.dart';
import 'light_out.dart';
import 'pod/pod_base.dart';

abstract class ActivityFactory {
  static Activity create(ActivitySetting setting, List<PodBase> podList) {
    List<ActivityPod> activityPods = _getActivityPods(podList);

    var activity = Activity()
        .withStations(setting.numberOfStations)
        .withNumberOfPods(setting.numberOfPods)
        .withNumberOfPlayers(setting.numberOfPlayers)
        .withNumberOfColorsPerPlayer(setting.numberOfColorsPerPlayer)
        .withNumberOfDistractingPods(setting.numberOfDistractingPods)
        .withActivityDuration(ActivityDurationFactory.getActivityDuration(
            setting.activityDuration))
        .withLightsOut(LightsOutFactory.getLightsOut(setting.lightsOut))
        .withLightDelay(LightDelayFactory.getLightDelay(setting.lightDelayTime))
        .withLightupMode(
            LightupModeFactory.getLightupMode(setting, activityPods))
        .withActivityPods(activityPods)
        .withColorToHit(Colors.red);

    if (setting.numberOfPlayers > 1) {
      activity.withCompetitionMode(setting.competitionMode);
    }

    return activity;
  }

  static List<ActivityPod> _getActivityPods(List<PodBase> podList) {
    List<ActivityPod> list = [];
    for (var pod in podList) {
      ActivityPod activityPod = ActivityPod(pod);
      list.add(activityPod);
    }
    return list;
  }
}
