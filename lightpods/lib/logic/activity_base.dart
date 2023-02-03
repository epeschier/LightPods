import '../models/activity_result.dart';
import '../models/activity_setting.dart';
import 'activity_duration.dart';
import 'activity_lightup_mode.dart';
import 'activity_pod.dart';
import 'light_delay.dart';

abstract class ActivityBase {
  final ActivitySetting setting;
  final List<ActivityPod> activityPods;
  Function? onActivityEnded;
  Function? onResultChanged;

  ActivityBase(this.setting, this.activityPods);

  late ActivityDuration duration;
  late LightDelay lightDelay;
  late LightupMode lightupMode;

  final ActivityResult activityResult = ActivityResult();
  bool get isRunning => _isRunning;

  bool _isRunning = false;

  int elapsedTimeInSeconds = 0;

  void tick() {
    elapsedTimeInSeconds++;
    if (duration.isDone(activityResult, elapsedTimeInSeconds)) {
      stop();
    }
  }

  void run() {
    _isRunning = true;

    activityResult.clear();
    elapsedTimeInSeconds = 0;

    installHitHandlers();

    startCycle();
  }

  void startCycle();

  void stop() {
    if (_isRunning) {
      _endActivity();
    }
  }

  void _endActivity() {
    print("activity ended");
    _isRunning = false;

    lightDelay.abort();
    uninstallHitHandlers();
    lightupMode.turnOffAllPods();

    onActivityEnded?.call();
  }

  void installHitHandlers() {
    for (var p in activityPods) {
      p.onHitOrTimeout = hitHandler;
    }
  }

  void uninstallHitHandlers() {
    for (var p in activityPods) {
      p.onHitOrTimeout = null;
    }
  }

  void hitHandler(int reactionTime, ActivityPod pod);
}
