import 'package:flutter/material.dart';

import '../logic/pod/pod_base.dart';
import '../models/activity_setting.dart';
import 'fake_pod.dart';
import 'pod_button.dart';

class DummyPodButtons extends StatelessWidget {
  final ActivitySetting setting;
  List<PodBase> podList = [];
  DummyPodButtons({super.key, required this.setting, required this.podList});

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];
    for (int i = 0; i < setting.numberOfPods; i++) {
      var fakePod = FakePod(i.toString());
      podList.add(fakePod);

      buttons.add(PodButton(
        pod: fakePod,
      ));
    }
    return Row(
      children: buttons,
    );
  }
}
