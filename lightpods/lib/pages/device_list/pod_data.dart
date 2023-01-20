import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:lightpods/theme/theme.dart';

import '../../logic/pod/pod_base.dart';

class PodData extends StatelessWidget {
  final PodBase pod;

  const PodData({super.key, required this.pod});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pod.name,
          style: ThemeColors.podInfoHeaderText,
        ),
        _getSubInfo(),
      ],
    ));
  }

  Widget _getSubInfo() => Row(
        children: [
          Text(
            pod.id,
            style: ThemeColors.podInfoSubText,
          ),
          // Transform.rotate(
          //   angle: 90 * math.pi / 180,
          //   child: const IconButton(
          //     icon: Icon(
          //       Icons.battery_5_bar,
          //       size: 28,
          //     ),
          //     onPressed: null,
          //   ),
          // ),
        ],
      );
}
