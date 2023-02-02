import 'dart:math';
import 'package:lightpods/models/distracting_colors.dart';
import 'package:lightpods/models/pod_colors.dart';
import '../models/player_color.dart';
import 'activity_pod.dart';

class PodsToActivate {
  late List<ActivityPod> podsToHit = [];
  late List<ActivityPod> distractingPods = [];
}

class LightupMode {
  final List<ActivityPod> pods;
  final DistractingColors distractingColors;
  final int numberOfSimultaneousActivePods;
  final PlayerColor hitColors;

  /// When set to true the same pod is not returned twice.
  late bool noDuplicate;

  LightupMode(
      {required this.pods,
      required this.distractingColors,
      required this.hitColors,
      required this.numberOfSimultaneousActivePods,
      this.noDuplicate = false});

  late PodsToActivate _podsToActivate;

  PodsToActivate getPods() {
    var numDistractingPods =
        _getNumberOfDistractingPods(numberOfSimultaneousActivePods);
    var numPodsToHit = numberOfSimultaneousActivePods - numDistractingPods;

    _podsToActivate = _createPodsToActivate(numPodsToHit, numDistractingPods);

    _setRandomColorsOnPodsToHit();
    _setRandomColorsOnDistractingPods();

    return _podsToActivate;
  }

  int _getNumberOfDistractingPods(int totalNumberOfPods) {
    if (distractingColors.size() == 0) {
      return 0;
    }

    var numDistractingPods = 0;
    for (var i = 0; i < totalNumberOfPods; i++) {
      if (_showDistractingPod()) {
        numDistractingPods++;
      }
    }
    return numDistractingPods;
  }

  bool _showDistractingPod() {
    var pct = Random().nextInt(100);
    return (pct < distractingColors.chanceToAppear);
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
      pod.color = PodColorService.distractingColors
          .getRandomColorFromIndexList(distractingColors.selectedColorIndex);
    });
  }

  void _setRandomColorsOnPodsToHit() {
    _podsToActivate.podsToHit.forEach((pod) {
      pod.color = hitColors.getRandomColor();
    });
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
