import 'package:flutter/material.dart';
import 'package:lightpods/models/activity_enums.dart';
import 'package:lightpods/partials/activity_setting/strike_out_setting.dart';
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
  late bool _inTextEditMode = false;
  final TextEditingController _controller = TextEditingController();
  bool _showCompetitionMode = false;

  @override
  void initState() {
    _addListenerForUpdatingName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _getWorkoutName(widget.activitySetting.name),
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
      _getNumberOfPlayers(setting.numberOfPlayers),
      _getNumberOfPods(setting.numberOfPods),
      _getActivePodsToLightUp(setting.numberOfSimultaneousActivePods),
      _getNumberOfStations(setting.numberOfStations),
      _getPlayerColors(
          setting.numberOfPlayers, setting.numberOfColorsPerPlayer),
      Visibility(
        visible: _showCompetitionMode,
        child: _getCompetitionMode(setting.competitionMode.index),
      ),
      _getNumberOfDistractingPods(setting.numberOfDistractingPods),
      ActivityDurationSetting(value: setting.activityDuration),
      LightsOutWidget(
        value: setting.lightsOut,
      ),
      LightDelayTimeWidget(
        value: setting.lightDelayTime,
      ),
      StrikeOutSetting(value: setting.strikeOut),
    ];

    return list;
  }

  void _addListenerForUpdatingName() {
    _controller.addListener(() {
      widget.activitySetting.name = _controller.text;
    });
  }

  Widget _getWorkoutName(String name) =>
      (_inTextEditMode) ? _getEditName(name) : _getName(name);

  Widget _getName(String name) => InkWell(
        child: Text(name),
        onTap: () {
          setState(() {
            _inTextEditMode = true;
          });
        },
      );

  Widget _getEditName(String name) {
    _controller.text = name;

    return TextField(
        controller: _controller,
        decoration: const InputDecoration(border: UnderlineInputBorder()));
  }

  Widget _getNumberOfPlayers(int numberOfPlayers) => ActivitySettingContainer(
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
        icon: Icons.wb_twighlight,
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

  Widget _getPlayerColors(int playerNumber, int numberOfColors) =>
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

  Widget _getNumberOfDistractingPods(int numberOfDistractingPods) =>
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

  Widget _getNumberOfStations(int numberOfStations) => ActivitySettingContainer(
        icon: Icons.flag,
        text: 'Stations',
        widget: NumberTicker(
          value: numberOfStations,
          minValue: 1,
          maxValue: 2,
          onValueChanged: (int value) {
            widget.activitySetting.numberOfStations = value;
          },
        ),
      );

  Widget _getCompetitionMode(int competitionMode) => MultipleChoice(
        icon: Icons.sports_kabaddi,
        selectedItem: competitionMode,
        onItemSelected: (int index) {
          widget.activitySetting.competitionMode =
              CompetitionType.values[index];
        },
        text: 'Competition Mode',
        values: const ['Regular', 'First to hit'],
      );

  Widget _getActivePodsToLightUp(int value) => ActivitySettingContainer(
        icon: Icons.share,
        text: 'Active Pods',
        subText: 'Number of pods that will light up simultaneously',
        widget: NumberTicker(
          value: value,
          minValue: 1,
          maxValue: 4, // TODO: max available pods
          onValueChanged: _onActivePodsToLightUpChanged,
        ),
      );

  void _onActivePodsToLightUpChanged(int value) {
    setState(() {
      widget.activitySetting.numberOfSimultaneousActivePods = value;
    });
  }
}
