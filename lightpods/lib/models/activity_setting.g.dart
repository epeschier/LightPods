// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivitySetting _$ActivitySettingFromJson(Map<String, dynamic> json) =>
    ActivitySetting()
      ..name = json['name'] as String
      ..id = json['id'] as int
      ..numberOfStations = json['numberOfStations'] as int
      ..numberOfPods = json['numberOfPods'] as int
      ..numberOfSimultaneousActivePods =
          json['numberOfSimultaneousActivePods'] as int
      ..numberOfPlayers = json['numberOfPlayers'] as int
      ..playerHitColors = (json['playerHitColors'] as List<dynamic>?)
              ?.map((e) => PlayerColor.fromJson(e as Map<String, dynamic>))
              .toList() ??
          []
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
      'playerHitColors':
          instance.playerHitColors.map((e) => e.toJson()).toList(),
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
