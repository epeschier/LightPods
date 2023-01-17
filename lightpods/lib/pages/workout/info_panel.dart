import 'package:flutter/material.dart';
import 'package:lightpods/models/activity_setting.dart';

import '../../components/color_bullets.dart';
import '../../models/pod_colors.dart';
import '../../theme/theme.dart';

class InfoPanel extends StatelessWidget {
  final ActivitySetting setting;

  InfoPanel({super.key, required this.setting});

  final _chipBackColor = ThemeColors.backgroundColor;
  final _chipTextColor = ThemeColors.lightPrimaryColor;

  @override
  Widget build(BuildContext context) => _getChipList();

  _getChipList() {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            _getInfoChip(Icons.person, setting.numberOfPlayers.toString()),
            _getInfoChip(Icons.wb_twighlight, setting.numberOfPods.toString()),
            _getInfoChip(
                Icons.share, setting.numberOfSimultaneousActivePods.toString()),
            Visibility(
                visible:
                    (setting.distractingColors.numberOfDistractingColors > 0),
                child: _getInfoChip(
                    Icons.alt_route, setting.distractingColors.toString())),
            _getInfoChip(Icons.schedule, setting.activityDuration.toString()),
            _getInfoChip(Icons.highlight, setting.lightsOut.toString()),
            _getInfoChip(
                Icons.hourglass_empty, setting.lightDelayTime.toString()),
            Visibility(
                visible: setting.strikeOut.value,
                child:
                    _getInfoChip(Icons.logout, setting.strikeOut.toString())),
            _getColorChip(Icons.palette,
                PodColors.getNumHitColors(setting.numberOfHitColors).toList()),
            Visibility(
                visible:
                    setting.distractingColors.numberOfDistractingColors > 0,
                child: _getColorChip(
                    Icons.alt_route, PodColors.getDistractingColors)),
          ],
        ));
  }

  Widget _getInfoChip(
    IconData icon,
    String label,
  ) {
    return Chip(
      labelPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Icon(
          icon,
          size: 20,
          color: ThemeColors.backgroundColor,
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
        width: 50 + (list.length * 24),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: _chipBackColor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(children: [
          CircleAvatar(
            maxRadius: 14,
            backgroundColor: Colors.white70,
            child: Icon(
              icon,
              size: 20,
              color: ThemeColors.backgroundColor,
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          ColorBullets(colors: list, size: 20),
        ]));
  }
}
