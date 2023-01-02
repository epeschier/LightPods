import 'package:flutter/material.dart';
import 'package:lightpods/logic/light_out.dart';
import '../logic/activity_duration.dart';
import '../models/activity_setting.dart';
import '../pages/create_workout_page.dart';
import '../partials/activity_info.dart';
import '../models/activity_enums.dart';

class ActivityListPage extends StatelessWidget {
  const ActivityListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activities'),
      ),
      body: _getActivityList(),
      floatingActionButton: FloatingActionButton(
          tooltip: "Create activity",
          onPressed: () {
            _navigateToCreateActivity(context);
          },
          child: const Icon(Icons.add)),
    );
  }

  ListView _getActivityList() {
    // TODO: get from stored activities
    List<Widget> containers = <Widget>[];
    var setting = _getActivitySetting();
    containers.add(ActivityInfo(
      setting: setting,
    ));

    return ListView(
      children: containers,
    );
  }

  void _navigateToCreateActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        var activitySetting = _getActivitySetting();
        return CreateWorkout(
          activitySetting: activitySetting,
        );
      }),
    );
  }

// TEMP
  ActivitySetting _getActivitySetting() {
    var duration = DurationSetting();
    duration.durationType = ActivityDurationType.hitsAndTimeout;
    duration.numberOfHits = 10;
    duration.timeout = 4;

    var lightDelay = LightDelayTimeSetting();
    lightDelay.fixedTime = 2000;
    lightDelay.delayTimeType = LightDelayTimeType.fixed;
    lightDelay.randomTimeMin = 1;
    lightDelay.randomTimeMax = 2;

    var lightsOut = LightsOutSetting();
    lightsOut.lightsOut = LightsOutType.timeout;
    lightsOut.timeout = 2;

    var setting = ActivitySetting();
    setting.name = "My Workout";
    setting.numberOfPlayers = 1;
    setting.numberOfPods = 2;
    setting.numberOfDistractingPods = 0;
    setting.numberOfStations = 1;
    setting.numberOfColorsPerPlayer = 1;
    setting.activityDuration = duration;
    setting.competitionMode = CompetitionType.regular;
    setting.lightsOut = lightsOut;
    setting.lightDelayTime = lightDelay;
    setting.lightupMode = LightupModeType.allAtOnce;

    return setting;
  }
}
