import 'package:flutter/material.dart';
import 'package:lightpods/pages/workout_page.dart';
import '../models/activity_enums.dart';
import '../models/activity_setting.dart';
import '../models/duration_setting.dart';
import '../models/light_delay_time_setting.dart';
import '../models/lights_out_setting.dart';
import '../theme/theme.dart';

class ActivityInfo extends StatelessWidget {
  final ActivitySetting setting;
  final Function? onEdit;

  const ActivityInfo({super.key, required this.setting, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: ThemeColors.primaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getName(),
          _getDescription(context),
        ],
      ),
    );
  }

  Widget _getName() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            setting.name,
            style: ThemeColors.headerText,
          ),
          InkWell(
            splashColor: ThemeColors.primaryColor,
            onTap: () {
              onEdit?.call();
            },
            child: Icon(
              Icons.edit,
              color: ThemeColors.accentColor,
            ),
          )
        ],
      );

  Widget _getDescription(BuildContext context) => InkWell(
      onTap: () {
        _navigateToWorkout(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              flex: 50,
              child: Column(children: [
                _getInfoPart(Icons.person, "${setting.numberOfPlayers} player"),
                _getInfoPart(
                    Icons.wb_twighlight, "${setting.numberOfPods} pods"),
                _getInfoPart(
                    Icons.palette, "${setting.numberOfColorsPerPlayer} color"),
                _getInfoPart(
                    Icons.alt_route, "${setting.numberOfDistractingPods}"),
              ])),
          Flexible(
              flex: 50,
              child: Column(children: [
                _getInfoPart(Icons.schedule,
                    _getActivityDurationText(setting.activityDuration)),
                _getInfoPart(
                    Icons.highlight, _getLightsOutText(setting.lightsOut)),
                _getInfoPart(Icons.hourglass_empty,
                    _getLightsDelaytimeText(setting.lightDelayTime)),
                Visibility(
                    visible: setting.strikeOut.value,
                    child: _getInfoPart(Icons.logout,
                        setting.strikeOut.count.toStringAsFixed(0))),
              ]))
        ],
      ));

  void _navigateToWorkout(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WorkoutPage(setting: setting);
    }));
  }

  Widget _getInfoPart(IconData icon, String text) => Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon),
          Text(" : $text"),
        ],
      ));

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

  String _getLightsOutText(LightsOutSetting setting) {
    String text = '';

    if (setting.lightsOut != LightsOutType.timeout) {
      text += 'hit';
    }

    if (setting.lightsOut != LightsOutType.hit) {
      if (text.isNotEmpty) {
        text += ' or ';
      }
      text += '${setting.timeout.toStringAsFixed(1)} s';
    }

    return text;
  }

  String _getLightsDelaytimeText(LightDelayTimeSetting setting) {
    String text = '';

    if (setting.delayTimeType == LightDelayTimeType.none) {
      text = 'none';
    }

    if (setting.delayTimeType == LightDelayTimeType.fixed) {
      text = '${setting.fixedTime.toStringAsFixed(1)} s';
    }

    if (setting.delayTimeType == LightDelayTimeType.random) {
      text =
          '${setting.randomTimeMin.toStringAsFixed(1)} - ${setting.randomTimeMax.toStringAsFixed(1)} s';
    }

    return text;
  }
}
