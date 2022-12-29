import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lightpods/components/rounded_icon_button.dart';
import 'package:lightpods/models/activity_result.dart';
import '../logic/pod_base.dart';
import '../models/activity_enums.dart';
import '../logic/activity_factory.dart';
import '../models/activity_setting.dart';
import '../partials/activity_timer.dart';
import '../logic/activity.dart';
import '../services/pod_service.dart';
import '../theme/theme.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final GlobalKey<ActivityTimerState> _activityTimerState =
      GlobalKey<ActivityTimerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Activity'),
        ),
        body: Column(children: [
          _getActivityTimer(),
          _infoCards(),
          _getDummyPodButtons()
        ]));
  }

  ActivityTimer _getActivityTimer() => ActivityTimer(
        onStart: _onStart,
        onStop: _onStop,
        tick: _onTick,
        key: _activityTimerState,
      );

  int _miss = 0;
  int _hits = 0;
  int _avg = 0;

  Widget _infoCards() => Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _info(_miss.toString(), 'Miss'),
          _info(_hits.toString(), 'Hits'),
          _info(_avg.toString(), 'Avg. Reaction')
        ],
      ));

  Widget _info(String text, String subTitle) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(10),
            color: ThemeColors.darkPrimaryColor,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text, style: const TextStyle(fontSize: 40)),
                Text(subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, color: ThemeColors.primaryTextColor)),
              ],
            )));
  }

  late Activity _activity;

  void _onStart() {
    _activity = _createActivity();
    _activity.subscribeToActivityEnd = _onActivityEnded;
    _activity.onResultChanged = _onResultChanged;
    _activity.run();
  }

  void _onStop() {
    _activity.stop();
  }

  void _onTick() {
    _activity.tick();
  }

  void _onActivityEnded() {
    print("activity ended");
    _activityTimerState.currentState!.stop();
  }

  void _onResultChanged(ActivityResult result) {
    setState(() {
      _miss = result.misses;
      _hits = result.hits;
      _avg = result.getAverageReationTime();
    });
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
    setting.activityDuration = ActivityDurationType.timeout;
    setting.durationNumberOfHits = 3;
    setting.durationTimeout = 5;
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
