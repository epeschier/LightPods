import 'package:flutter/material.dart';
import 'package:lightpods/components/color_indicator.dart';
import 'package:lightpods/components/number_ticker.dart';
import 'package:lightpods/partials/activity_setting/lights_out_setting.dart';
import 'package:lightpods/partials/multiple_choice.dart';

import '../components/toggle_options.dart';
import '../partials/activity_setting.dart';
import '../partials/activity_setting/activity_duration_setting.dart';
import '../partials/activity_setting/lights_delay_time_setting.dart';
import '../theme/theme.dart';

class CreateWorkout extends StatefulWidget {
  const CreateWorkout({super.key});

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
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
        _getActivityCompetitionMode(),
        _activityPlayerColors,
        _activityColors,
        _activityDistractingPods,
        const ActivityDurationSetting(),
        const LightsOutSetting(),
        const LightDelayTimeSetting(),
        _getActivityLightupMode(),
        _getNavButtons(),
      ]),
    );
  }

  final _buttonStyle = ElevatedButton.styleFrom(
    shape: const StadiumBorder(),
    padding: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
    backgroundColor: ThemeColors.buttonColor,
    foregroundColor: ThemeColors.backgroundColor,
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  );

  Widget _getNavButtons() => Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    style: _buttonStyle,
                    onPressed: () {},
                    child: const Text('Back'),
                  ))),
          Expanded(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: _buttonStyle,
                    onPressed: () {},
                    child: const Text('Next'),
                  ))),
        ],
      ));

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

  Widget _getActivityCompetitionMode() => MultipleChoice(
        icon: Icons.sports_kabaddi,
        onItemSelected: _onCompetitionModeSelected,
        text: 'Competition Mode',
        values: const ['Regular', 'First to hit'],
      );

  void _onCompetitionModeSelected(int index) {}

  Widget _getActivityLightupMode() => MultipleChoice(
        icon: Icons.workspaces_filled,
        onItemSelected: (int index) {},
        text: 'Lightup Mode',
        values: const ['Random', 'All at once'],
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
