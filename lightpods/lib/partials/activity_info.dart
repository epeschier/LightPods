import 'package:flutter/material.dart';
import '../models/activity_enums.dart';
import '../models/activity_setting.dart';
import '../theme/theme.dart';

class ActivityInfo extends StatelessWidget {
  final ActivitySetting setting;
  final Function? onEdit;

  const ActivityInfo({super.key, required this.setting, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return _getCard();
  }

  Widget _getCard() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: ThemeColors.backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_getName(), _getDescription()],
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

  Widget _getDescription() => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              flex: 50,
              child: Column(children: [
                _getInfoPart(Icons.person, "${setting.numberOfPlayers} player"),
                _getInfoPart(
                    Icons.panorama_fish_eye, "${setting.numberOfPods} pods"),
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
                _getInfoPart(Icons.workspaces_filled,
                    _getLightupModeText(setting.lightupMode)),
              ]))
        ],
      );

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

  String _getLightupModeText(LightupModeType setting) {
    return (setting == LightupModeType.random) ? 'random' : 'all';
  }
}
