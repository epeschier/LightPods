import 'package:flutter/material.dart';
import 'package:lightpods/components/list_divider.dart';
import '../../models/activity_setting.dart';
import '../../models/activity_setting_list.dart';
import '../edit_workout/edit_workout_page.dart';
import 'activity_info.dart';

class WorkoutListPage extends StatefulWidget {
  const WorkoutListPage({super.key});

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  late ActivitySettingList _workouts = ActivitySettingList();

  @override
  void initState() {
    ActivitySettingList.load().then((value) => setState(() {
          _workouts = value;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
      ),
      body: _getWorkoutList(),
      floatingActionButton: _getActionButton(),
    );
  }

  Widget _getWorkoutList() {
    List<Widget> containers = <Widget>[];

    for (var i = 0; i < _workouts.list.length; i++) {
      var setting = _workouts.list[i];
      containers.add(ActivityInfo(
        onEdit: () {
          _navigateToEditWorkout(context, setting);
        },
        setting: setting,
      ));

      if (i < _workouts.list.length - 1) {
        containers.add(ListDivider());
      }
    }

    return ListView(
      children: containers,
    );
  }

  FloatingActionButton _getActionButton() => FloatingActionButton(
      tooltip: "Create activity",
      onPressed: () {
        var activity = ActivitySetting();
        _navigateToEditWorkout(context, activity);
      },
      child: const Icon(Icons.add));

  void _navigateToEditWorkout(
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
    activity.sanityCheck();
    setState(() {
      if (activity.id > 0) {
        var item = _workouts.getItem(activity.id);
        item.copyWith(activity);
      } else {
        _workouts.add(activity);
      }
      _workouts.save();
    });
  }
}
