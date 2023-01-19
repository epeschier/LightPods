import 'dart:math';
import 'package:lightpods/models/distracting_colors.dart';
import 'package:lightpods/models/pod_colors.dart';
import 'activity_pod.dart';

class PodsToActivate {
  late List<ActivityPod> podsToHit = [];
  late List<ActivityPod> distractingPods = [];
}

class LightupMode {
  final List<ActivityPod> pods;
  final DistractingColors distractingColors;
  final int numberOfSimultaneousActivePods;
  final int numberOfHitColors;

  /// When set to true the same pod is not returned twice.
  late bool noDuplicate;

  LightupMode(
      {required this.pods,
      required this.distractingColors,
      required this.numberOfHitColors,
      required this.numberOfSimultaneousActivePods,
      this.noDuplicate = false});

  late PodsToActivate _podsToActivate;

  PodsToActivate getPods() {
    var numDistractingPods = _getNumberOfDistractingPods();
    var numPodsToHit = numberOfSimultaneousActivePods - numDistractingPods;

    _podsToActivate = _createPodsToActivate(numPodsToHit, numDistractingPods);

    _setRandomColorsOnPodsToHit();
    _setRandomColorsOnDistractingPods();

    //var podsToChooseFrom = _getRandomPods(numberOfSimultaneousActivePods, pods);

    // var setPods = Set.from(pods);
    // var setPodsToHit = Set.from(_podsToActivate.podsToHit);
    // List<ActivityPod> distractingList =
    //     List.from(setPods.difference(setPodsToHit));
    // _podsToActivate.distractingPods = _getRandomPods(
    //     distractingColors, distractingList, _podsToActivate.distractingPods);

    return _podsToActivate;
  }

  int _getNumberOfDistractingPods() {
    var numDistractingPods = 0;
    if (distractingColors.numberOfDistractingColors > 0) {
      var pct = Random().nextDouble();
      numDistractingPods = (numberOfSimultaneousActivePods * pct).round();
    }
    return numDistractingPods;
  }

  PodsToActivate _createPodsToActivate(
      int numPodsToHit, int numDistractingPods) {
    pods.shuffle();
    var podsToActivate = PodsToActivate()
      ..podsToHit = pods.take(numPodsToHit).toList()
      ..distractingPods =
          pods.skip(numPodsToHit).take(numDistractingPods).toList();
    return podsToActivate;
  }

  void _setRandomColorsOnDistractingPods() {
    _podsToActivate.distractingPods.forEach((pod) {
      pod.color = PodColors.getRandomDistractingColor(
          distractingColors.numberOfDistractingColors);
    });
  }

  void _setRandomColorsOnPodsToHit() {
    _podsToActivate.podsToHit.forEach((pod) {
      pod.color = PodColors.getRandomHitColor(numberOfHitColors);
    });
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

  bool allCorrectPodsToHitAreHit() =>
      !_podsToActivate.podsToHit.any((element) => element.isActive);

  void turnOffAllPods() {
    for (var p in pods) {
      p.off();
    }
  }
}
