import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lightpods/partials/workout/info_block.dart';
import 'package:lightpods/partials/workout/info_panel.dart';
import 'package:lightpods/test/pod_button.dart';
import 'package:lightpods/models/activity_result.dart';
import '../test/fake_pod.dart';
import '../logic/pod/pod_base.dart';
import '../logic/activity_factory.dart';
import '../models/activity_setting.dart';
import '../partials/workout/activity_timer.dart';
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
        floatingActionButton: _getInfoButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        body: Column(children: [
          _getActivityTimer(),
          _infoCards(),
          Row(
            children: _buttons,
          )
        ]));
  }

  FloatingActionButton _getInfoButton() => FloatingActionButton(
      onPressed: _showInfo, child: const Icon(Icons.info_outline));

  void _showInfo() {
    showModalBottomSheet<void>(
      backgroundColor: ThemeColors.darkPrimaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (BuildContext context) {
        return InfoPanel(setting: widget.setting);
      },
    );
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
          InfoBlock(text: _miss.toString(), description: 'Miss'),
          InfoBlock(text: _hits.toString(), description: 'Hits'),
          InfoBlock(text: _avg.toString(), description: 'Avg. Reaction')
        ],
      ));

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
