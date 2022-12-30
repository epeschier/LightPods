import 'package:flutter/material.dart';
import 'package:lightpods/models/activity_enums.dart';
import 'activity_lightup_mode.dart';
import 'activity_pod.dart';
import 'light_delay.dart';
import 'light_out.dart';
import 'activity_duration.dart';
import '../models/activity_result.dart';

class Activity {
  Function? onActivityEnded;
  Function? onResultChanged;

  final ActivityResult _activityResult = ActivityResult();

  Activity();

  List<ActivityPod> _podsToHit = [];

  bool _isRunning = false;

  void run() {
    _isRunning = true;
    _activityResult.clear();
    _turnOffAllPods();
    _installHitHandlers();

    _startCycle();
  }

  void tick() {
    _activityResult.elapsedTimeInSeconds++;
    _checkForActivityEnd();
  }

  void _startCycle() {
    print("Start Cycle: wait for next light to turn on");
    _lightDelay.wait(_activatePods);
  }

  void _activatePods() {
    _podsToHit = _lightupMode.getPodsToTurnOn();
    _turnOnPods(_podsToHit);

    _lightsOut.wait(_lightsOutHandler);
  }

  void _lightsOutHandler() {
    print("lights out after timeout");
    _registerMissedPods(_podsToHit);
    _turnOffAllPods();
    _checkForActivityEnd();
  }

  void _registerMissedPods(List<ActivityPod> pods) {
    for (var p in pods) {
      if (p.isActive) {
        _activityResult.misses++;
      }
    }
  }

  void _turnOnPods(List<ActivityPod> pods) {
    for (var p in pods) {
      p.activate(_colorToHit);
    }
    //_activateDistractingPods(_podToHit);
  }

  void _hitHandler(int reactionTime, ActivityPod pod) {
    print("hit: ${pod.id} in ${reactionTime}");
    if (reactionTime > 0) {
      _activityResult.hitReactionTimeInMs.add(reactionTime);
      if (_allActivePodsHit()) {
        _lightsOut.abort();
        _startCycle();
      }
    } else {
      _activityResult.misses++;
    }
    onResultChanged?.call(_activityResult);
    _checkForActivityEnd();
  }

  bool _allActivePodsHit() {
    // TODO: don't include distracting pods.
    bool anyPodActivated = false;
    for (var pod in _activityPods) {
      anyPodActivated |= pod.isActive;
    }
    return !anyPodActivated;
  }

  void _checkForActivityEnd() {
    if (_activityDuration.isDone(_activityResult)) {
      stop();
      _turnOffAllPods();
    }
  }

  void stop() {
    if (_isRunning) {
      print("activity ended");
      _isRunning = false;

      _lightsOut.abort();
      _lightDelay.abort();
      _uninstallHitHandlers();
      _turnOffAllPods();

      onActivityEnded?.call();
    }
  }

  void _activateDistractingPods(ActivityPod mainPod) {
    // TODO: activate a number of distracting pods that are not the mainPod.
  }

  void _turnOffAllPods() {
    for (var p in _activityPods) {
      p.off();
    }
  }

  void _installHitHandlers() {
    for (var pod in _activityPods) {
      pod.onHitOrTimeout = _hitHandler;
    }
  }

  void _uninstallHitHandlers() {
    for (var pod in _activityPods) {
      pod.onHitOrTimeout = null;
    }
  }

  /*** Builder ***/
  late Color _colorToHit;
  Activity withColorToHit(Color color) {
    _colorToHit = color;
    return this;
  }

  late List<ActivityPod> _activityPods;
  Activity withActivityPods(List<ActivityPod> pods) {
    _activityPods = pods;
    return this;
  }

  late int _numberOfStations;
  Activity withStations(int stations) {
    _numberOfStations = stations;
    return this;
  }

  late int _numberOfPods;
  Activity withNumberOfPods(int numberOfPods) {
    _numberOfPods = numberOfPods;
    return this;
  }

  late int _numberOfPlayers;
  Activity withNumberOfPlayers(int numberOfPlayers) {
    _numberOfPlayers = numberOfPlayers;
    return this;
  }

  late int _numberOfColorsPerPlayer;
  Activity withNumberOfColorsPerPlayer(int numberOfColorsPerPlayer) {
    _numberOfColorsPerPlayer = numberOfColorsPerPlayer;
    return this;
  }

  late int _numberOfDistractingPods;
  Activity withNumberOfDistractingPods(int numberOfDistractingPods) {
    _numberOfDistractingPods = numberOfDistractingPods;
    return this;
  }

  late CompetitionType _competitionType;
  Activity withCompetitionMode(CompetitionType type) {
    _competitionType = type;
    return this;
  }

  late ActivityDuration _activityDuration;
  Activity withActivityDuration(ActivityDuration activityDuration) {
    _activityDuration = activityDuration;
    return this;
  }

  late LightsOut _lightsOut;
  Activity withLightsOut(LightsOut lightsOut) {
    _lightsOut = lightsOut;
    return this;
  }

  late LightDelay _lightDelay;
  Activity withLightDelay(LightDelay lightDelay) {
    _lightDelay = lightDelay;
    return this;
  }

  late LightupMode _lightupMode;
  Activity withLightupMode(LightupMode lightupMode) {
    _lightupMode = lightupMode;
    return this;
  }

  /*** End builder methods ***/

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
