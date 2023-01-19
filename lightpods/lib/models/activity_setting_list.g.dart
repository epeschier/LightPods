// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_setting_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivitySettingList _$ActivitySettingListFromJson(Map<String, dynamic> json) =>
    ActivitySettingList()
      ..list = (json['list'] as List<dynamic>)
          .map((e) => ActivitySetting.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ActivitySettingListToJson(
        ActivitySettingList instance) =>
    <String, dynamic>{
      'list': instance.list.map((e) => e.toJson()).toList(),
    };
