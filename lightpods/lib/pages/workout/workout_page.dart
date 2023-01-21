import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lightpods/pages/workout/clock/rotating_second.dart';
import 'info_block.dart';
import 'info_panel.dart';
import 'package:lightpods/partials/pod_count.dart';
import 'package:lightpods/test/pod_button.dart';
import 'package:lightpods/models/activity_result.dart';
import '../../test/fake_pod.dart';
import '../../logic/pod/pod_base.dart';
import '../../logic/activity_factory.dart';
import '../../models/activity_setting.dart';
import 'clock/clock.dart';
import '../../logic/activity.dart';
import '../../services/pod_service.dart';
import '../../theme/theme.dart';

class WorkoutPage extends StatefulWidget {
  final ActivitySetting setting;

  const WorkoutPage({super.key, required this.setting});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final GlobalKey<ClockState> _activityTimerState = GlobalKey<ClockState>();

  List<PodBase> _podList = [];

  //late List<PodButton> _buttons;

  int _miss = 0;
  int _hits = 0;
  int _avg = 0;

  @override
  void initState() {
    _activity = _createActivity();
    _activity.onActivityEnded = _onActivityEnded;
    _activity.onResultChanged = _onResultChanged;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (_activity.isRunning) {
            return false;
          }
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.setting.name),
              actions: [_getPodCount()],
            ),
            floatingActionButton: _getInfoButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterTop,
            body: Column(children: [
              _getActivityTimer(),
              _infoCards(),

              // Visibility(
              //     visible: (_buttons != null),
              //     child: Row(
              //       children: _buttons,
              //     ))
            ])));
  }

  Widget _getPodCount() => PodCount(count: _podList.length);

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

  Clock _getActivityTimer() => Clock(
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

  void _onStart() => _activity.run();

  void _onStop() => _activity.stop();

  void _onReset() {
    setState(() {
      _miss = 0;
      _hits = 0;
      _avg = 0;
    });
  }

  void _onTick() => _activity.tick();

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

  Activity _createActivity() {
    PodService podService = GetIt.I.get<PodService>();
    _podList = podService.getPods();

    //_buttons = _getDummyPodButtons(widget.setting);

    Activity activity = ActivityFactory.create(widget.setting, _podList);

    return activity;
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
}
