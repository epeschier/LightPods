import 'package:flutter/material.dart';
import '../components/color_indicator.dart';
import '../components/number_ticker.dart';
import '../models/activity_setting.dart';
import '../partials/activity_setting/lights_out_setting.dart';
import '../partials/multiple_choice.dart';
import '../partials/activity_setting_container.dart';
import '../partials/activity_setting/activity_duration_setting.dart';
import '../partials/activity_setting/lights_delay_time_widget.dart';
import '../theme/theme.dart';

class CreateWorkout extends StatefulWidget {
  final ActivitySetting activitySetting;
  const CreateWorkout({super.key, required this.activitySetting});

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  bool _showCompetitionMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Workout'),
      ),
      body: ListView(children: _getActivityList()),
    );
  }

  List<Widget> _getActivityList() {
    var setting = widget.activitySetting;

    List<Widget> list = [
      _getActivityNumberOfPlayers(setting.numberOfPlayers),
      _getActivityPods(setting.numberOfPods),
      _getActivityStations(setting.numberOfStations),
      _getActivityPlayerColors(
          setting.numberOfPlayers, setting.numberOfColorsPerPlayer),
      Visibility(
        visible: _showCompetitionMode,
        child: _getActivityCompetitionMode(setting.competitionMode.index),
      ),
      _getActivityDistractingPods(setting.numberOfDistractingPods),
      ActivityDurationSetting(
        durationSetting: setting.activityDuration,
      ),
      LightsOutWidget(
        selectedItem: setting.lightsOut,
      ),
      LightDelayTimeWidget(
        setting: setting.lightDelayTime,
      ),
      _getActivityLightupMode(setting.lightupMode.index),
      _getButtons(),
    ];

    return list;
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

  Widget _getActivityStations(int numberOfStations) => ActivitySettingContainer(
        icon: Icons.flag,
        text: 'Stations',
        widget: NumberTicker(
          value: numberOfStations,
          minValue: 1,
        ),
      );

  Widget _getActivityDistractingPods(int numberOfDistractingPods) =>
      ActivitySettingContainer(
        icon: Icons.alt_route,
        text: 'Distracting Pods',
        widget: NumberTicker(
          value: numberOfDistractingPods,
          minValue: 0,
        ),
      );

  Widget _getActivityPods(int numberOfPods) => ActivitySettingContainer(
        icon: Icons.panorama_fish_eye,
        text: 'Pods',
        subText: 'Number of available Pods',
        widget: NumberTicker(
          value: numberOfPods,
          minValue: 1,
        ),
      );

  Widget _getActivityNumberOfPlayers(int numberOfPlayers) =>
      ActivitySettingContainer(
        icon: Icons.person,
        text: 'Players',
        subText: 'per Station',
        widget: NumberTicker(
          value: numberOfPlayers,
          minValue: 1,
          maxValue: 2,
          onValueChanged: _onNumberOfPlayersChanged,
        ),
      );

  void _onNumberOfPlayersChanged(int value) {
    setState(() {
      widget.activitySetting.numberOfPlayers = value;
      _showCompetitionMode = value > 1;
    });
  }

  Widget _getActivityPlayerColors(int playerNumber, int numberOfColors) =>
      ActivitySettingContainer(
        icon: Icons.palette,
        text: 'Colors',
        subText: 'Per Player',
        widget: NumberTicker(
            value: numberOfColors,
            minValue: 1,
            maxValue: 4,
            onValueChanged: onNumberOfColorsChanged),
        subWidget: _getActivityColors(playerNumber, numberOfColors),
      );

  void onNumberOfColorsChanged(int value) {
    setState(() {
      widget.activitySetting.numberOfColorsPerPlayer = value;
    });
  }

  Widget _getActivityCompetitionMode(int competitionMode) => MultipleChoice(
        icon: Icons.sports_kabaddi,
        selectedItem: competitionMode,
        onItemSelected: _onCompetitionModeSelected,
        text: 'Competition Mode',
        values: const ['Regular', 'First to hit'],
      );

  void _onCompetitionModeSelected(int index) {}

  Widget _getActivityLightupMode(int lightupMode) => MultipleChoice(
        icon: Icons.workspaces_filled,
        selectedItem: lightupMode,
        onItemSelected: (int index) {},
        text: 'Lightup Mode',
        values: const ['Random', 'All at once'],
      );

  Widget _getActivityColors(int numberOfPlayers, int numberOfColors) {
    List<Widget> colorRows = [];

    for (int i = 0; i < numberOfPlayers; i++) {
      colorRows.add(_getColorRow(i, numberOfColors));
    }
    return Column(
      children: colorRows,
    );
  }

  Widget _getColorRow(int playerNumber, int numberOfColors) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Player ${playerNumber + 1}',
            style: ThemeColors.headerText,
          ),
          ColorIndicator(
            playerNumber: playerNumber,
            numberOfColors: numberOfColors,
          ),
        ],
      );

  Widget _getButtons() => Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: _buttonStyle,
            onPressed: () {},
            child: const Text('Save'),
          )
        ],
      ));
}
