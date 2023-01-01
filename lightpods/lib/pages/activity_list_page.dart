import 'package:flutter/material.dart';
import 'package:lightpods/pages/create_workout_page.dart';
import 'package:lightpods/partials/activity_info.dart';

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

    containers.add(ActivityInfo());

    return ListView(
      children: containers,
    );
  }

  void _navigateToCreateActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateWorkout()),
    );
  }
}
