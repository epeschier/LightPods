import 'package:flutter/material.dart';
import 'package:lightpods/components/number_ticker.dart';
import 'package:lightpods/theme/theme.dart';

import '../components/toggle_options.dart';
import '../models/activity_enums.dart';
import '../partials/activity_setting.dart';

class CreateWorkout extends StatefulWidget {
  const CreateWorkout({super.key});

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  final ButtonStyle _nextButtonStyle =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Workout'),
      ),
      body: ListView(children: <Widget>[
        _activityPods,
        _activityDistractingPods,
        _activityPlayers,
        _activityStations,
        _activityCompetitionMode,
        ActivitySetting(
          icon: Icons.alarm,
          text: 'Activity Duration',
          subText: ActivityDescription
              .activityDurationExplanation[_activityDurationIndex],
          widget: ToggleOptions(
            values: const ['Hits', 'Timeout', 'Both'],
            selectedItem: 0,
            onClick: _onActivityDurationToggleClick,
          ),
        ),
        ActivitySetting(
          icon: Icons.lightbulb,
          text: 'Lights out',
          subText: ActivityDescription.lightsOutExplanation[_lightsOutIndex],
          widget: ToggleOptions(
            values: const ['Hit', 'Timeout', 'Both'],
            selectedItem: 0,
            onClick: _onLightsOutExplanationToggleClick,
          ),
        ),
        ActivitySetting(
          icon: Icons.light_mode,
          text: 'Light Delay Time',
          subText:
              ActivityDescription.lightDelayTimeExplanation[_lightDelayIndex],
          widget: ToggleOptions(
            values: const ['None', 'Fixed', 'Random'],
            selectedItem: 0,
            onClick: _onLightsDelayToggleClick,
          ),
        ),
        _activityLightupMode,
        ElevatedButton(
          style: _nextButtonStyle,
          onPressed: () {},
          child: const Text('Next'),
        ),
      ]),
    );
  }

  final Widget _activityStations = const ActivitySetting(
    icon: Icons.flag,
    text: 'Stations',
    widget: NumberTicker(),
  );

  final Widget _activityDistractingPods = const ActivitySetting(
    icon: Icons.alt_route,
    text: 'Distracting Pods',
    widget: NumberTicker(
      minValue: 0,
    ),
  );

  final Widget _activityPods = const ActivitySetting(
    icon: Icons.panorama_fish_eye,
    text: 'Pods',
    subText: 'Number of available Pods',
    widget: NumberTicker(),
  );

  final Widget _activityPlayers = const ActivitySetting(
    icon: Icons.person,
    text: 'Players',
    subText: 'per Station',
    widget: NumberTicker(maxValue: 2),
  );

  final Widget _activityCompetitionMode = const ActivitySetting(
    icon: Icons.sports_kabaddi,
    text: 'Competition Mode',
    widget: ToggleOptions(
      values: ['Regular', 'First to hit'],
      selectedItem: 0,
    ),
  );

  final Widget _activityLightupMode = const ActivitySetting(
    icon: Icons.workspaces_filled,
    text: 'Lightup Mode',
    widget: ToggleOptions(
      values: ['Random', 'All at once'],
      selectedItem: 0,
    ),
  );

  int _activityDurationIndex = 0;
  void _onActivityDurationToggleClick(int index) {
    setState(() {
      _activityDurationIndex = index;
    });
  }

  int _lightsOutIndex = 0;
  void _onLightsOutExplanationToggleClick(int index) {
    setState(() {
      _lightsOutIndex = index;
    });
  }

  int _lightDelayIndex = 0;
  void _onLightsDelayToggleClick(int index) {
    setState(() {
      _lightDelayIndex = index;
    });
  }
}
