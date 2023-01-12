import 'activity_pod.dart';

class PodsToActivate {
  late List<ActivityPod> podsToHit = [];
  late List<ActivityPod> distractingPods = [];
}

class LightupMode {
  final List<ActivityPod> pods;
  final int numberOfDistractingPods;
  final int numberOfActivePods;

  LightupMode(this.pods, this.numberOfDistractingPods, this.numberOfActivePods);

  late final PodsToActivate _podsToActivate = PodsToActivate();

  PodsToActivate getPods() {
    pods.shuffle();

    _podsToActivate.podsToHit = pods.take(numberOfActivePods).toList();
    _podsToActivate.distractingPods =
        pods.skip(numberOfActivePods).take(numberOfDistractingPods).toList();

    return _podsToActivate;
  }

  bool isDistractingPod(ActivityPod pod) =>
      _podsToActivate.distractingPods.contains(pod);

  bool isPodToHit(ActivityPod pod) => _podsToActivate.podsToHit.contains(pod);

  bool allPodsToHitAreHit() =>
      !_podsToActivate.podsToHit.any((element) => element.isActive);

  void turnOffAllPods() {
    for (var p in pods) {
      p.off();
    }
  }

  void installHitHandlers(Function handler) {
    for (var p in pods) {
      p.onHitOrTimeout = handler;
    }
  }

  void uninstallHitHandlers() {
    for (var p in pods) {
      p.onHitOrTimeout = null;
    }
  }
}
