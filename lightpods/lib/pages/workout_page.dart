import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lightpods/test/pod_button.dart';
import 'package:lightpods/models/activity_result.dart';
import '../test/fake_pod.dart';
import '../logic/pod/pod_base.dart';
import '../logic/activity_factory.dart';
import '../models/activity_setting.dart';
import '../partials/activity_timer.dart';
import '../logic/activity.dart';
import '../services/bluetooth_device_service.dart';
import '../services/pod_service.dart';
import '../theme/theme.dart';

class WorkoutPage extends StatefulWidget {
  final ActivitySetting setting;

  const WorkoutPage({super.key, required this.setting});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final GlobalKey<ActivityTimerState> _activityTimerState =
      GlobalKey<ActivityTimerState>();

  List<PodBase> _podList = [];
  late List<PodButton> _buttons;
  int _miss = 0;
  int _hits = 0;
  int _avg = 0;

  @override
  void initState() {
    _buttons = _getDummyPodButtons(widget.setting);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.setting.name),
        ),
        body: Column(children: [
          _getActivityTimer(),
          _infoCards(),
          Row(
            children: _buttons,
          )
        ]));
  }

  ActivityTimer _getActivityTimer() => ActivityTimer(
        onStart: _onStart,
        onStop: _onStop,
        onReset: _onReset,
        tick: _onTick,
        key: _activityTimerState,
      );

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
            margin: const EdgeInsets.all(8),
            color: ThemeColors.primaryColor,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text, style: const TextStyle(fontSize: 30)),
                Text(subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12, color: ThemeColors.lightPrimaryColor)),
              ],
            )));
  }

  late Activity _activity;

  void _onStart() {
    _activity = _createActivity();
    _activity.onActivityEnded = _onActivityEnded;
    _activity.onResultChanged = _onResultChanged;
    _activity.run();
  }

  void _onStop() {
    _activity.stop();
  }

  void _onReset() {
    setState(() {
      _miss = 0;
      _hits = 0;
      _avg = 0;
    });
  }

  void _onTick() {
    _activity.tick();
  }

  void _onActivityEnded() {
    _activityTimerState.currentState!.stop();
  }

  void _onResultChanged(ActivityResult result) {
    setState(() {
      _miss = result.misses;
      _hits = result.hits;
      _avg = result.getAverageReationTime();
    });
  }

  List<PodButton> _getDummyPodButtons(ActivitySetting setting) {
    List<PodButton> buttons = [];
    _podList = [];
    for (int i = 0; i < setting.numberOfPods; i++) {
      var fakePod = FakePod(i.toString());
      _podList.add(fakePod);

      buttons.add(PodButton(
        pod: fakePod,
      ));
    }
    return buttons;
  }

  Activity _createActivity() {
    //final PodService _podService = GetIt.I.get<PodService>();
    //_podList = _podService.getPods();

    Activity activity = ActivityFactory.create(widget.setting, _podList);

    return activity;
  }
}
