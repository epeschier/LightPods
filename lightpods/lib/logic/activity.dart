import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lightpods/models/activity_enums.dart';
import 'activity_lightup_mode.dart';
import 'activity_pod.dart';
import 'light_delay.dart';
import 'light_out.dart';
import 'activity_duration.dart';
import '../models/activity_result.dart';

class Activity {
  late ActivityResult _activityResult;
  final _random = Random();
  late ActivityPod _podToHit;

  late FocusLogic _focusLogic;

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

  void run() {
    _activityResult.clear();
    _clearAllPods();
    _installHitHandlers();

    _startCycle();
  }

  void _startCycle() {
    print("wait for next light to turn on");
    _lightDelay.wait(_activatePods);
  }

  void _activatePods() {
    print("activate pods");

    var podsToTurnOn = _lightupMode.getPodsToTurnOn();
    _turnOnPods(podsToTurnOn);

    _lightsOut.wait();
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
    } else {
      _activityResult.misses++;
    }
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
    // TODO: kill all futures.
  }

  void _activateDistractingPods(ActivityPod mainPod) {
    // TODO: activate a number of distracting pods that are not the mainPod.
  }

  void _clearAllPods() {
    for (var pod in _activityPods) {
      pod.off();
    }
  }

  // void _onEnd(int reactionTime, ActivityPod pod) {
  //   if ((pod != _podToHit) || (reactionTime <= 0)) {
  //     _activityResult.misses++;
  //   } else {
  //     _activityResult.hitReactionTimeInMs.add(reactionTime);
  //   }
  // }
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
