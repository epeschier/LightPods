import 'package:lightpods/models/lights_out_setting.dart';

import 'activity.dart';
import 'activity_pod.dart';
import '../models/activity_setting.dart';
import 'pod/pod_base.dart';

abstract class ActivityFactory {
  static Activity create(ActivitySetting setting, List<PodBase> podList) {
    List<ActivityPod> activityPods =
        _getActivityPods(podList, setting.lightsOut);

    return Activity(setting, activityPods);
  }

  static List<ActivityPod> _getActivityPods(
      List<PodBase> podList, LightsOutSetting setting) {
    List<ActivityPod> list = [];
    for (var pod in podList) {
      ActivityPod activityPod = ActivityPod(pod, setting);
      list.add(activityPod);
    }
    return list;
  }
}
