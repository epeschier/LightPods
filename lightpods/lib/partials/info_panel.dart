import 'package:flutter/material.dart';
import 'package:lightpods/models/activity_setting.dart';

import '../components/color_bullets.dart';
import '../models/pod_colors.dart';
import '../theme/theme.dart';

class InfoPanel extends StatelessWidget {
  final ActivitySetting setting;

  Color? chipBackColor;
  Color? chipTextColor;
  Color? iconColor;
  Color? iconBackgroundColor;
  double? iconSize;

  InfoPanel(
      {super.key,
      required this.setting,
      this.chipBackColor,
      this.chipTextColor,
      this.iconColor,
      this.iconBackgroundColor,
      this.iconSize});

  Color get _chipBackColor => chipBackColor ?? ThemeColors.backgroundColor;
  Color get _chipTextColor => chipTextColor ?? ThemeColors.lightPrimaryColor;
  Color get _iconColor => iconColor ?? ThemeColors.backgroundColor;
  Color get _iconBackgroundColor => iconBackgroundColor ?? Colors.white70;
  double get _iconSize => iconSize ?? 20.0;

  @override
  Widget build(BuildContext context) => _getChipList();

  _getChipList() {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            _getPlayerInfoChip(),
            _getPodInfoChip(),
            _getSimultaneousPidsInfoChip(),
            _getDistractingColorsInfoChip(),
            _getActivityDurationInfoChip(),
            _getLightsOutInfoChip(),
            _getLightDelayTimeInfoChip(),
            _getStrikeOutInfoChip(),
            _getNumberOfHitColorsInfoChip(),
            _getDistractingColors(),
          ],
        ));
  }

  Widget _getPlayerInfoChip() =>
      _getInfoChip(Icons.person, setting.numberOfPlayers.toString());

  Widget _getPodInfoChip() =>
      _getInfoChip(Icons.wb_twighlight, setting.numberOfPods.toString());

  Widget _getSimultaneousPidsInfoChip() => _getInfoChip(
      Icons.share, setting.numberOfSimultaneousActivePods.toString());

  Widget _getDistractingColorsInfoChip() => Visibility(
      visible: (setting.distractingColors.numberOfDistractingColors > 0),
      child:
          _getInfoChip(Icons.alt_route, setting.distractingColors.toString()));

  Widget _getActivityDurationInfoChip() =>
      _getInfoChip(Icons.schedule, setting.activityDuration.toString());

  Widget _getLightsOutInfoChip() =>
      _getInfoChip(Icons.highlight, setting.lightsOut.toString());

  Widget _getLightDelayTimeInfoChip() =>
      _getInfoChip(Icons.hourglass_empty, setting.lightDelayTime.toString());

  Widget _getStrikeOutInfoChip() => Visibility(
      visible: setting.strikeOut.value,
      child: _getInfoChip(Icons.logout, setting.strikeOut.toString()));

  Widget _getNumberOfHitColorsInfoChip() => _getColorChip(Icons.palette,
      PodColors.getNumHitColors(setting.numberOfHitColors).toList());

  Widget _getDistractingColors() => Visibility(
      visible: setting.distractingColors.numberOfDistractingColors > 0,
      child: _getColorChip(
          Icons.alt_route,
          PodColors.getNumDistractingColors(setting.numberOfDistractingColors)
              .toList()));

  Widget _getInfoChip(
    IconData icon,
    String label,
  ) {
    return Chip(
      labelPadding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
      avatar: CircleAvatar(
        backgroundColor: _iconBackgroundColor,
        child: Icon(
          icon,
          size: _iconSize,
          color: _iconColor,
        ),
      ),
      label: Text(
        label,
        style: TextStyle(color: _chipTextColor),
      ),
      backgroundColor: _chipBackColor,
      padding: const EdgeInsets.all(8.0),
    );
  }

  Widget _getColorChip(IconData icon, List<Color> list) {
    return Container(
        width: 44 + (list.length * 22),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: _chipBackColor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(children: [
          CircleAvatar(
            maxRadius: 11,
            backgroundColor: _iconBackgroundColor,
            child: Icon(
              icon,
              size: _iconSize,
              color: _iconColor,
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          ColorBullets(colors: list, size: 20),
        ]));
  }
}
