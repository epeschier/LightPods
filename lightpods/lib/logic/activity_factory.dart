import 'activity.dart';
import 'activity_pod.dart';
import '../models/activity_setting.dart';
import 'pod/pod_base.dart';

abstract class ActivityFactory {
  static Activity create(ActivitySetting setting, List<PodBase> podList) {
    List<ActivityPod> activityPods = _getActivityPods(podList);

    return Activity(setting, activityPods);
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
