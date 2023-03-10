import 'package:flutter/material.dart';
import 'package:lightpods/pages/edit_workout/activity_setting/distracting_color_chance.dart';
import 'package:lightpods/pages/edit_workout/activity_setting/player_color_setting.dart';

import '../../components/list_divider.dart';
import '../../models/activity_enums.dart';
import '../../components/number_ticker.dart';
import '../../models/activity_setting.dart';
import '../../models/pod_colors.dart';
import 'activity_setting/lights_out_setting.dart';
import 'multiple_choice.dart';
import 'activity_setting/strike_out_setting.dart';
import 'activity_setting/activity_setting_container.dart';
import 'activity_setting/activity_duration_setting.dart';
import 'activity_setting/lights_delay_time_widget.dart';
import '../../theme/theme.dart';

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
                child: Icon(
                  Icons.save,
                  color: ThemeColors.accentColor,
                ),
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
      PlayerColorSetting(
          icon: Icons.person,
          colors: PodColorService.hitColors,
          selectedColorIndex:
              widget.activitySetting.playerHitColors[0].selectedColorIndex,
          text: "Player 1",
          subText: "Active colors",
          onValueChanged: (List<int> value) => widget
              .activitySetting.playerHitColors[0].selectedColorIndex = value),
      Visibility(
          visible: setting.numberOfPlayers > 1,
          child: PlayerColorSetting(
              icon: Icons.group,
              colors: PodColorService.hitColors,
              selectedColorIndex:
                  widget.activitySetting.playerHitColors[1].selectedColorIndex,
              text: "Player 2",
              subText: "Active colors",
              onValueChanged: (List<int> value) => widget.activitySetting
                  .playerHitColors[1].selectedColorIndex = value)),
      ListDivider(),
      Visibility(
          visible: setting.numberOfPlayers > 1,
          child: _getNumberOfStations(setting.numberOfStations)),
      Visibility(
        visible: _showCompetitionMode,
        child: _getCompetitionMode(setting.competitionMode.index),
      ),
      _getNumberOfPods(setting.numberOfPods),
      ListDivider(),
      _getActivePodsToLightUp(setting.numberOfSimultaneousActivePods),
      ListDivider(),
      LightsOutWidget(
        onChanged: () => setState(() {}),
        value: setting.lightsOut,
      ),
      ListDivider(),
      Visibility(
          visible: setting.lightsOut.lightsOut != LightsOutType.hit,
          child: Column(children: [
            DistactingColorChance(value: setting.distractingColors),
            ListDivider()
          ])),
      ActivityDurationSetting(value: setting.activityDuration),
      ListDivider(),
      LightDelayTimeWidget(
        value: setting.lightDelayTime,
      ),
      ListDivider(),
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
        icon: Icons.groups,
        text: 'Players',
        subText: 'per station',
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
