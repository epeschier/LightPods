import 'package:flutter/material.dart';
import 'package:lightpods/pages/workout_page.dart';
import '../components/list_container.dart';
import '../models/activity_enums.dart';
import '../models/activity_setting.dart';
import '../models/duration_setting.dart';
import '../theme/theme.dart';

class ActivityInfo extends StatelessWidget {
  final ActivitySetting setting;
  final Function? onEdit;

  const ActivityInfo({super.key, required this.setting, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ListContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getNameAndDescription(context),
          _getEditIcon(),
        ],
      ),
    );
  }

  Widget _getEditIcon() => InkWell(
        splashColor: ThemeColors.primaryColor,
        onTap: () {
          onEdit?.call();
        },
        child: Icon(
          Icons.edit,
          color: ThemeColors.accentColor,
        ),
      );

  Widget _getNameAndDescription(BuildContext context) => InkWell(
      onTap: () {
        _navigateToWorkout(context);
      },
      child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getName(),
              _getDescription(context),
            ],
          )));

  Widget _getName() => Text(
        setting.name,
        style: ThemeColors.headerText,
      );

  Widget _getDescription(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _getInfoPart(
              "${setting.numberOfPlayers} player ${setting.numberOfPods} pods, "),
          _getInfoPart(_getActivityDurationText(setting.activityDuration)),
        ],
      );

  void _navigateToWorkout(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WorkoutPage(setting: setting);
    }));
  }

  Widget _getInfoPart(String text) => Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(text, style: ThemeColors.subText),
      );

  String _getActivityDurationText(DurationSetting setting) {
    String text = '';
    if (setting.durationType != ActivityDurationType.timeout) {
      text += '${setting.numberOfHits.toStringAsFixed(0)} hits';
    }
    if (setting.durationType != ActivityDurationType.numberOfHits) {
      if (text.isNotEmpty) {
        text += ' / ';
      }
      text += '${setting.timeout.toStringAsFixed(0)} min';
    }
    return text;
  }
}
