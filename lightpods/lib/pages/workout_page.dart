import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lightpods/components/rounded_icon_button.dart';
import '../logic/pod_base.dart';
import '../models/activity_enums.dart';
import '../logic/activity_factory.dart';
import '../models/activity_setting.dart';
import '../partials/activity_timer.dart';
import '../logic/activity.dart';
import '../services/pod_service.dart';

class ActivityPage extends StatelessWidget {
  ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Activity'),
        ),
        body: Column(children: [
          ActivityTimer(
            onStart: _onStart,
            onStop: _onStop,
          ),
          _getDummyPodButtons()
        ]));
  }

  late Activity _activity;
  void _onStart() {
    _activity = _createActivity();
    _activity.run();
  }

  void _onStop() {
    _activity.stop();
  }

  Widget _getDummyPodButtons() => Row(
        children: [
          RoundedIconButton(
              icon: Icons.access_alarm,
              onClick: () {
                _clickFake('1');
              }),
          RoundedIconButton(
              icon: Icons.done,
              onClick: () {
                _clickFake('2');
              })
        ],
      );

  late List<FakePod> _podList;
  Activity _createActivity() {
    // final PodService _podService = GetIt.I.get<PodService>();

    _podList = _createFakes(); // = _podService.

    var setting = ActivitySetting();
    setting.numberOfPods = 2;
    setting.activityDuration = ActivityDurationType.numberOfHits;
    setting.durationNumberOfHits = 3;
    setting.lightsOut = LightsOutType.hit;
    setting.lightDelayTime = LightDelayTimeType.fixed;
    setting.lightDelayFixedTime = 2000;
    setting.lightupMode = LightupModeType.random;

    Activity activity = ActivityFactory.create(setting, _podList);
    return activity;
  }

  void _clickFake(String id) {
    var pod = _podList.firstWhere((x) => x.id == id);
    pod.initiateClickCallback();
  }

  List<FakePod> _createFakes() {
    List<FakePod> list = [];

    list.add(FakePod('1'));
    list.add(FakePod('2'));

    return list;
  }
}

class FakePod extends PodBase {
  final String _id;

  FakePod(this._id);

  @override
  String get id => _id;

  @override
  void lightOff() {}

  @override
  void setLight(Color color) {
    print("lighton ");
  }

  void initiateClickCallback() {
    onHit!();
  }
}
