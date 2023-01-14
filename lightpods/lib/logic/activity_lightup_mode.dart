import 'activity_pod.dart';

class PodsToActivate {
  late List<ActivityPod> podsToHit = [];
  late List<ActivityPod> distractingPods = [];
}

class LightupMode {
  final List<ActivityPod> pods;
  final int numberOfDistractingPods;
  final int numberOfActivePods;

  /// When set to true the same pod is not returned twice.
  final bool noDuplicate;

  LightupMode(this.pods, this.numberOfDistractingPods, this.numberOfActivePods,
      [this.noDuplicate = false]);

  late final PodsToActivate _podsToActivate = PodsToActivate();

  PodsToActivate getPods() {
    _podsToActivate.podsToHit =
        _getRandomPods(numberOfActivePods, pods, _podsToActivate.podsToHit);

    var setPods = Set.from(pods);
    var setPodsToHit = Set.from(_podsToActivate.podsToHit);
    List<ActivityPod> distractingList =
        List.from(setPods.difference(setPodsToHit));
    _podsToActivate.distractingPods = _getRandomPods(numberOfDistractingPods,
        distractingList, _podsToActivate.distractingPods);

    return _podsToActivate;
  }

  List<ActivityPod> _getRandomPods(
      int numToGet, List<ActivityPod> list, List<ActivityPod> exclude) {
    List<ActivityPod> availableHitPods = pods;
    if (noDuplicate) {
      var usedSet = Set.from(exclude);
      var available = Set.from(list);
      availableHitPods = List.from(available.difference(usedSet));
    }
    availableHitPods.shuffle();

    return availableHitPods.take(numToGet).toList();
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
