import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ActivityInfo extends StatelessWidget {
  const ActivityInfo({super.key});

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

  Widget _getName() => Text(
        "Workout name",
        style: ThemeColors.headerText,
      );

  Widget _getDescription() => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              flex: 50,
              child: Column(children: [
                _getInfoPart(Icons.person, "1 player"),
                _getInfoPart(Icons.panorama_fish_eye, "2 pods"),
                _getInfoPart(Icons.palette, "1 color"),
              ])),
          Flexible(
              flex: 50,
              child: Column(children: [
                _getInfoPart(Icons.schedule, "5 hits"),
                _getInfoPart(Icons.highlight, "hit"),
                _getInfoPart(Icons.hourglass_empty, "fixed: 2 sec"),
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
}
