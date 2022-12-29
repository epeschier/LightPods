import 'package:flutter/material.dart';
import 'package:lightpods/models/activity_enums.dart';
import 'activity_lightup_mode.dart';
import 'activity_pod.dart';
import 'light_delay.dart';
import 'light_out.dart';
import 'activity_duration.dart';
import '../models/activity_result.dart';

class Activity {
  late Function? _onActivityEnded;
  Function? onResultChanged;

  ActivityResult _activityResult = ActivityResult();
  late ActivityPod _podToHit;

  Activity();

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

  set subscribeToActivityEnd(Function callback) {
    _onActivityEnded = callback;
  }

  /*** End builder methods ***/
  bool _isRunning = false;

  void run() {
    _isRunning = true;
    _activityResult.clear();
    _clearAllPods();
    _installHitHandlers();

    _startCycle();
  }

  void tick() {
    print("activity tick");
    _activityResult.elapsedTimeInSeconds++;
    _checkForActivityEnd();
  }

  void _startCycle() {
    print("wait for next light to turn on");
    _lightDelay.wait(_activatePods);
  }

  void _activatePods() {
    print("activate pods");

    var podsToTurnOn = _lightupMode.getPodsToTurnOn();
    _turnOnPods(podsToTurnOn);

    _lightsOut.wait(_lightsOutHandler);
  }

  void _lightsOutHandler() {
    print("lights out after timeout");
    _activityResult.misses++;
    _checkForActivityEnd();
  }

  void _turnOnPods(List<ActivityPod> pods) {
    for (var p in pods) {
      p.activate(_colorToHit);
    }
    //_activateDistractingPods(_podToHit);
  }

  void _installHitHandlers() {
    for (var pod in _activityPods) {
      pod.callbackOnHit = _hitHandler;
    }
  }

  void _hitHandler(int reactionTime, ActivityPod pod) {
    print("hit: ${pod.id} in ${reactionTime}");
    if (reactionTime > 0) {
      _activityResult.hitReactionTimeInMs.add(reactionTime);
      _lightsOut.abort();
    } else {
      _activityResult.misses++;
    }
    onResultChanged?.call();
    _checkForActivityEnd();
  }

  void _checkForActivityEnd() {
    if (_activityDuration.isDone(_activityResult)) {
      stop();
      _clearAllPods();
    } else {
      _startCycle();
    }
  }

  void stop() {
    if (_isRunning) {
      _isRunning = false;

      _lightsOut.abort();
      _lightDelay.abort();

      _onActivityEnded?.call();
    }
  }

  void _activateDistractingPods(ActivityPod mainPod) {
    // TODO: activate a number of distracting pods that are not the mainPod.
  }

  void _clearAllPods() {
    for (var pod in _activityPods) {
      pod.off();
    }
  }
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
