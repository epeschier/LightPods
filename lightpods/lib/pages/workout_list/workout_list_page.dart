import 'package:flutter/material.dart';
import 'package:lightpods/components/list_divider.dart';
import '../../models/activity_setting.dart';
import '../edit_workout/edit_workout_page.dart';
import 'activity_info.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({super.key});

  @override
  State<ActivityListPage> createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
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
      body: _getActivityList(),
      floatingActionButton: _getActionButton(),
    );
  }

  Widget _getActivityList() {
    List<Widget> containers = <Widget>[];

    for (var i = 0; i < _workouts.list.length; i++) {
      var setting = _workouts.list[i];
      containers.add(ActivityInfo(
        onEdit: () {
          _navigateToEditActivity(context, setting);
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
    activity.sanityCheck();
    setState(() {
      if (activity.id > 0) {
        var item = _workouts.getItem(activity.id);
        item.copyWith(activity);
      } else {
        _workouts.add(activity);
      }
      _workouts.save().then((value) => print("save $value"));
    });
  }
}
