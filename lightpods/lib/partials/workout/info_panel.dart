import 'package:flutter/material.dart';
import 'package:lightpods/models/activity_setting.dart';

import 'info_block.dart';

class InfoPanel extends StatelessWidget {
  final ActivitySetting setting;

  const InfoPanel({super.key, required this.setting});

  @override
  Widget build(BuildContext context) => _getContent();

  Widget _getContent() => SizedBox(
        height: 200,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InfoBlock(
                text: setting.numberOfPods.toString(),
                description: 'Pods',
                icon: Icons.wb_twighlight,
              ),
              InfoBlock(
                text: '2 min',
                description: 'Duration',
                icon: Icons.timer,
              ),
              InfoBlock(
                text: '2 sec',
                description: 'Light Delay',
                icon: Icons.hourglass_empty,
              ),
            ],
          ),
        ),
      );
}
