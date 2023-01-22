import 'package:flutter/material.dart';
import 'package:lightpods/partials/info_panel.dart';
import 'package:lightpods/pages/workout/workout_page.dart';
import '../../components/list_container.dart';
import '../../models/activity_setting.dart';
import '../../theme/theme.dart';

class ActivityInfo extends StatelessWidget {
  final ActivitySetting setting;
  final Function? onEdit;

  const ActivityInfo({super.key, required this.setting, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ListContainer(
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _getNameAndDescription(context),
          ),
          _getEditIcon(),
        ],
      ),
    );
  }

  Widget _getEditIcon() => InkWell(
        splashColor: ThemeColors.primaryColor,
        onTap: () {
          onEdit?.call();
        },
        child: Icon(
          Icons.edit,
          color: ThemeColors.accentColor,
        ),
      );

  Widget _getNameAndDescription(BuildContext context) => InkWell(
      onTap: () {
        _navigateToWorkout(context);
      },
      child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getName(),
              InfoPanel(
                  setting: setting,
                  iconSize: 16,
                  chipBackColor: ThemeColors.darkPrimaryColor),
            ],
          )));

  Widget _getName() => Text(
        setting.name,
        style: ThemeColors.headerText,
      );

  void _navigateToWorkout(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WorkoutPage(setting: setting);
    }));
  }
}
