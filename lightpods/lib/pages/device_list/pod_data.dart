import 'package:flutter/material.dart';

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
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(pod.id),
      ],
    ));
  }
}
