import 'package:flutter/material.dart';
import 'package:lightpods/models/activity_enums.dart';
import '../components/color_indicator.dart';
import '../components/number_ticker.dart';
import '../models/activity_setting.dart';
import '../partials/activity_setting/lights_out_setting.dart';
import '../partials/multiple_choice.dart';
import '../partials/activity_setting/activity_setting_container.dart';
import '../partials/activity_setting/activity_duration_setting.dart';
import '../partials/activity_setting/lights_delay_time_widget.dart';
import '../theme/theme.dart';

class EditWorkout extends StatefulWidget {
  final ActivitySetting activitySetting;
  const EditWorkout({super.key, required this.activitySetting});

  @override
  State<EditWorkout> createState() => _EditWorkoutState();
}

class _EditWorkoutState extends State<EditWorkout> {
  bool _showCompetitionMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Workout'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context, widget.activitySetting);
                },
                child: const Icon(Icons.save),
              ))
        ],
      ),
      body: ListView(children: _getActivityList()),
    );
  }

  List<Widget> _getActivityList() {
    var setting = widget.activitySetting;

    List<Widget> list = [
      _getActivityNumberOfPlayers(setting.numberOfPlayers),
      _getNumberOfPods(setting.numberOfPods),
      _getActivityStations(setting.numberOfStations),
      _getActivityPlayerColors(
          setting.numberOfPlayers, setting.numberOfColorsPerPlayer),
      Visibility(
        visible: _showCompetitionMode,
        child: _getActivityCompetitionMode(setting.competitionMode.index),
      ),
      _getActivityDistractingPods(setting.numberOfDistractingPods),
      ActivityDurationSetting(value: setting.activityDuration),
      LightsOutWidget(
        value: setting.lightsOut,
      ),
      LightDelayTimeWidget(
        value: setting.lightDelayTime,
      ),
      _getActivityLightupMode(setting.lightupMode.index),
    ];

    return list;
  }

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

  Widget _getNumberOfPods(int numberOfPods) => ActivitySettingContainer(
        icon: Icons.panorama_fish_eye,
        text: 'Pods',
        subText: 'Number of available Pods',
        widget: NumberTicker(
          value: numberOfPods,
          minValue: 1,
          onValueChanged: (int value) {
            widget.activitySetting.numberOfPods = value;
          },
        ),
      );

  Widget _getActivityPlayerColors(int playerNumber, int numberOfColors) =>
      ActivitySettingContainer(
        icon: Icons.palette,
        text: 'Colors',
        subText: 'Per Player',
        widget: NumberTicker(
            value: numberOfColors,
            minValue: 1,
            maxValue: 4,
            onValueChanged: (int value) {
              setState(() {
                widget.activitySetting.numberOfColorsPerPlayer = value;
              });
            }),
        subWidget: _getActivityColors(
            playerNumber, widget.activitySetting.numberOfColorsPerPlayer),
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
        crossAxisAlignment: CrossAxisAlignment.center,
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

  Widget _getActivityDistractingPods(int numberOfDistractingPods) =>
      ActivitySettingContainer(
        icon: Icons.alt_route,
        text: 'Distracting Pods',
        widget: NumberTicker(
          value: numberOfDistractingPods,
          minValue: 0,
          onValueChanged: (int value) {
            widget.activitySetting.numberOfDistractingPods = value;
          },
        ),
      );

  Widget _getActivityStations(int numberOfStations) => ActivitySettingContainer(
        icon: Icons.flag,
        text: 'Stations',
        widget: NumberTicker(
          value: numberOfStations,
          minValue: 1,
          onValueChanged: (int value) {
            widget.activitySetting.numberOfStations = value;
          },
        ),
      );

  Widget _getActivityCompetitionMode(int competitionMode) => MultipleChoice(
        icon: Icons.sports_kabaddi,
        selectedItem: competitionMode,
        onItemSelected: (int index) {
          widget.activitySetting.competitionMode =
              CompetitionType.values[index];
        },
        text: 'Competition Mode',
        values: const ['Regular', 'First to hit'],
      );

  Widget _getActivityLightupMode(int lightupMode) => MultipleChoice(
        icon: Icons.workspaces_filled,
        selectedItem: lightupMode,
        onItemSelected: (int index) {
          widget.activitySetting.lightupMode = LightupModeType.values[index];
        },
        text: 'Lightup Mode',
        values: const ['Random', 'All at once'],
      );

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
}
