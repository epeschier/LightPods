import 'package:flutter/material.dart';
import 'package:lightpods/components/color_indicator.dart';

import '../../components/color_bullets.dart';
import '../../theme/theme.dart';

class PlayerScore extends StatelessWidget {
  final String playerName;
  final int score;
  final List<Color> colors;

  const PlayerScore(
      {super.key,
      required this.playerName,
      required this.score,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return _info(playerName, "subTitle");
  }

  Widget _info(String text, String subTitle) => _getContainer(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getPlayerAndColor(text),
          const SizedBox(height: 10),
          _getDetailText("Hits: $score"),
          const SizedBox(height: 4),
          _getDetailText("Avg. reaction: $score"),
        ],
      ));

  Widget _getContainer(Widget child) => Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
          color: ThemeColors.darkPrimaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      child: Padding(padding: const EdgeInsets.all(8), child: child));

  Widget _getPlayerAndColor(String text) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              )),
          ColorBullets(colors: colors)
        ],
      );

  Widget _getDetailText(String text) => Text(text,
      style: TextStyle(fontSize: 12, color: ThemeColors.lightPrimaryColor));
}
