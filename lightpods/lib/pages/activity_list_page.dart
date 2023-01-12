import 'package:flutter/material.dart';
import '../models/activity_setting.dart';
import '../models/duration_setting.dart';
import '../models/light_delay_time_setting.dart';
import '../models/lights_out_setting.dart';
import 'edit_workout_page.dart';
import '../partials/activity_info.dart';
import '../models/activity_enums.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({super.key});

  @override
  State<ActivityListPage> createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  List<ActivitySetting> _list = [];

  @override
  void initState() {
    // TODO: get from stored activities
    var setting = _getActivitySetting();
    _list.add(setting);

    var secondSetting = ActivitySetting().copyWith(setting);
    secondSetting.name = "Workout 2";
    secondSetting.numberOfPods = 4;

    _list.add(secondSetting);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activities'),
      ),
      body: _getActivityList(),
      floatingActionButton: _getActionButton(),
    );
  }

  Widget _getActivityList() {
    List<Widget> containers = <Widget>[];

    for (var setting in _list) {
      containers.add(ActivityInfo(
        onEdit: () {
          _navigateToEditActivity(context, setting);
        },
        setting: setting,
      ));
    }

    return ListView(
      children: containers,
    );
  }

  FloatingActionButton _getActionButton() => FloatingActionButton(
      tooltip: "Create activity",
      onPressed: () {
        var activity = ActivitySetting();
        _navigateToEditActivity(context, activity);
      },
      child: const Icon(Icons.add));

  void _navigateToEditActivity(
      BuildContext context, ActivitySetting setting) async {
    var data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return EditWorkout(
          activitySetting: ActivitySetting().copyWith(setting),
        );
      }),
    ) as ActivitySetting?;
    if (data != null) {
      _updateActivity(data);
    }
  }

  void _updateActivity(ActivitySetting activity) {
    setState(() {
      if (activity.id > 0) {
        var item = _list.firstWhere((element) => element.id == activity.id);
        item.copyWith(activity);
      } else {
        // TODO: use service for list and id.
        activity.id = 10;
        _list.add(activity);
      }
    });
  }

// TEMP
  ActivitySetting _getActivitySetting() {
    var duration = DurationSetting();
    duration.durationType = ActivityDurationType.hitsAndTimeout;
    duration.numberOfHits = 10;
    duration.timeout = 4;

    var lightDelay = LightDelayTimeSetting();
    lightDelay.fixedTime = 2;
    lightDelay.delayTimeType = LightDelayTimeType.fixed;
    lightDelay.randomTimeMin = 1;
    lightDelay.randomTimeMax = 2;

    var lightsOut = LightsOutSetting();
    lightsOut.lightsOut = LightsOutType.timeout;
    lightsOut.timeout = 2;

    var setting = ActivitySetting();
    setting.name = "My Workout";
    setting.id = 1;
    setting.numberOfPlayers = 1;
    setting.numberOfPods = 2;
    setting.numberOfDistractingPods = 0;
    setting.numberOfStations = 1;
    setting.numberOfHitColors = 1;
    setting.activityDuration = duration;
    setting.competitionMode = CompetitionType.regular;
    setting.lightsOut = lightsOut;
    setting.lightDelayTime = lightDelay;

    return setting;
  }
}
