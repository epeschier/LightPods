import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'activity_setting.dart';

part 'activity_setting_list.g.dart';

@JsonSerializable(explicitToJson: true)
class ActivitySettingList extends ChangeNotifier {
  late List<ActivitySetting> list;

  ActivitySettingList() {
    list = [];
  }

  void add(ActivitySetting item) {
    item.id = list.length + 1;
    list.add(item);
    notifyListeners();
  }

  ActivitySetting getItem(int id) =>
      list.firstWhere((element) => element.id == id);

  factory ActivitySettingList.fromJson(Map<String, dynamic> json) =>
      _$ActivitySettingListFromJson(json);

  Map<String, dynamic> toJson() => _$ActivitySettingListToJson(this);

  static const storageKey = 'activity_settings';

  Future save() async {
    final prefs = await SharedPreferences.getInstance();
    var data = toJson();
    String encodedMap = json.encode(data);
    return prefs.setString(storageKey, encodedMap);
  }

  static Future<ActivitySettingList> load() async {
    var list = ActivitySettingList();
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(storageKey);
    if (data != null) {
      var datamap = json.decode(data);
      list = ActivitySettingList.fromJson(datamap);
    }

    return list;
  }
}
