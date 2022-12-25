import 'package:flutter/material.dart';
import 'package:lightpods/components/number_ticker.dart';
import 'package:lightpods/theme/theme.dart';

import '../components/toggle_options.dart';

class CreateWorkout extends StatefulWidget {
  CreateWorkout({super.key});

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Setup'),
      ),
      body: ListView(children: <Widget>[
        const GeneralItem(
          icon: Icons.flag,
          text: 'Stations',
          widget: NumberTicker(),
        ),
        const GeneralItem(
          icon: Icons.panorama_fish_eye,
          text: 'Pods',
          widget: NumberTicker(),
        ),
        const GeneralItem(
          icon: Icons.person,
          text: 'Players',
          subText: 'per Station',
          widget: NumberTicker(maxValue: 2),
        ),
        GeneralItem(
          icon: Icons.alarm,
          text: 'Activity Duration',
          subText: 'xxx',
          widget: ToggleOptions(
            values: const ['Hits', 'Timeout', 'Both'],
            onClick: _onActivityDurtationToggleClick,
          ),
        ),
        GeneralItem(
          icon: Icons.lightbulb,
          text: 'Lights out',
          subText: _activityDurationExplanation[_activityDurationIndex],
          widget: ToggleOptions(
            values: ['Hit', 'Timeout', 'Both'],
            onClick: _onActivityDurtationToggleClick,
          ),
        ),
        GeneralItem(
          icon: Icons.light_mode,
          text: 'Light Delay Time',
          subText: 'xxx',
          widget: ToggleOptions(
            values: ['None', 'Fixed', 'Random'],
            onClick: _onActivityDurtationToggleClick,
          ),
        ),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text('Next'),
        ),
      ]),
    );
  }

  static const List<String> _activityDurationExplanation = [
    'The activity will end after the number of hits you set.',
    'The activity will end when the time you set runs out.',
    'Either you reach the number of hits you set or the time you set runs out.'
  ];
  int _activityDurationIndex = 0;
  void _onActivityDurtationToggleClick(int index) {
    setState(() {
      _activityDurationIndex = index;
    });
  }
}

class GeneralItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subText;
  final Widget widget;

  const GeneralItem(
      {super.key,
      required this.icon,
      required this.text,
      required this.widget,
      this.subText});

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 80,
        decoration: BoxDecoration(
          color: ThemeColors.backgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 40,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      //color: Colors.black,
                      letterSpacing: 0.5,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    subText ?? '',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 128, 128, 128),
                      letterSpacing: 0.5,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          )),
          widget,
        ]));
  }
}
