import 'package:flutter/material.dart';
import 'package:lightpods/components/color_indicator.dart';
import 'package:lightpods/components/number_ticker.dart';
import 'package:lightpods/partials/activity_setting/lights_out_setting.dart';

import '../components/toggle_options.dart';
import '../partials/activity_setting.dart';
import '../partials/activity_setting/activity_duration_setting.dart';
import '../partials/activity_setting/lights_delay_time_setting.dart';

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
        _activityStations,
        _activityPods,
        _activityNumberOfPlayers,
        _activityPlayerColors,
        _activityColors,
        _activityDistractingPods,
        _activityCompetitionMode,
        const ActivityDurationSetting(),
        const LightsOutSetting(),
        const LightDelayTimeSetting(),
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

  final Widget _activityNumberOfPlayers = const ActivitySetting(
    icon: Icons.person,
    text: 'Players',
    subText: 'per Station',
    widget: NumberTicker(maxValue: 2),
  );

  final Widget _activityPlayerColors = const ActivitySetting(
    icon: Icons.palette,
    text: 'Colors',
    subText: 'Per Player',
    widget: NumberTicker(maxValue: 10),
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

  final Widget _activityColors = const ActivitySetting(
    icon: Icons.flag,
    text: 'Player 1',
    widget: ColorIndicator(
      playerNumber: 1,
      numberOfColors: 2,
    ),
  );
}
