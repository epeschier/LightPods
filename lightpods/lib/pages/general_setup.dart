import 'package:flutter/material.dart';
import 'package:lightpods/components/number_ticker.dart';
import 'package:lightpods/theme/theme.dart';

class GeneralSetup extends StatelessWidget {
  GeneralSetup({super.key});

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Setup'),
      ),
      body: ListView(children: <Widget>[
        const GeneralItem(icon: Icons.flag, text: 'Stations'),
        const GeneralItem(icon: Icons.panorama_fish_eye, text: 'Pods'),
        const GeneralItem(
            icon: Icons.person,
            text: 'Players',
            subText: 'per Station',
            maxValue: 2),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text('Next'),
        ),
      ]),
    );
  }
}

class GeneralItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subText;
  final int? maxValue;
  const GeneralItem(
      {super.key,
      required this.icon,
      required this.text,
      this.subText,
      this.maxValue});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
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
          NumberTicker(maxValue: maxValue),
        ]));
  }
}
