// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_setting.dart';

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

ActivitySetting _$ActivitySettingFromJson(Map<String, dynamic> json) =>
    ActivitySetting()
      ..name = json['name'] as String
      ..id = json['id'] as int
      ..numberOfStations = json['numberOfStations'] as int
      ..numberOfPods = json['numberOfPods'] as int
      ..numberOfSimultaneousActivePods =
          json['numberOfSimultaneousActivePods'] as int
      ..numberOfPlayers = json['numberOfPlayers'] as int
      ..numberOfHitColors = json['numberOfHitColors'] as int
      ..numberOfDistractingColors = json['numberOfDistractingColors'] as int
      ..strikeOut =
          StrikeOut.fromJson(json['strikeOut'] as Map<String, dynamic>)
      ..competitionMode =
          $enumDecode(_$CompetitionTypeEnumMap, json['competitionMode'])
      ..activityDuration = DurationSetting.fromJson(
          json['activityDuration'] as Map<String, dynamic>)
      ..lightsOut =
          LightsOutSetting.fromJson(json['lightsOut'] as Map<String, dynamic>)
      ..lightDelayTime = LightDelayTimeSetting.fromJson(
          json['lightDelayTime'] as Map<String, dynamic>)
      ..distractingColors = DistractingColors.fromJson(
          json['distractingColors'] as Map<String, dynamic>);

Map<String, dynamic> _$ActivitySettingToJson(ActivitySetting instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'numberOfStations': instance.numberOfStations,
      'numberOfPods': instance.numberOfPods,
      'numberOfSimultaneousActivePods': instance.numberOfSimultaneousActivePods,
      'numberOfPlayers': instance.numberOfPlayers,
      'numberOfHitColors': instance.numberOfHitColors,
      'numberOfDistractingColors': instance.numberOfDistractingColors,
      'strikeOut': instance.strikeOut.toJson(),
      'competitionMode': _$CompetitionTypeEnumMap[instance.competitionMode]!,
      'activityDuration': instance.activityDuration.toJson(),
      'lightsOut': instance.lightsOut.toJson(),
      'lightDelayTime': instance.lightDelayTime.toJson(),
      'distractingColors': instance.distractingColors.toJson(),
    };

const _$CompetitionTypeEnumMap = {
  CompetitionType.regular: 'regular',
  CompetitionType.firstToHit: 'firstToHit',
};

StrikeOut _$StrikeOutFromJson(Map<String, dynamic> json) => StrikeOut()
  ..value = json['value'] as bool
  ..count = json['count'] as int;

Map<String, dynamic> _$StrikeOutToJson(StrikeOut instance) => <String, dynamic>{
      'value': instance.value,
      'count': instance.count,
    };
