// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duration_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DurationSetting _$DurationSettingFromJson(Map<String, dynamic> json) =>
    DurationSetting()
      ..durationType =
          $enumDecode(_$ActivityDurationTypeEnumMap, json['durationType'])
      ..numberOfHits = (json['numberOfHits'] as num).toDouble()
      ..timeout = (json['timeout'] as num).toDouble();

Map<String, dynamic> _$DurationSettingToJson(DurationSetting instance) =>
    <String, dynamic>{
      'durationType': _$ActivityDurationTypeEnumMap[instance.durationType]!,
      'numberOfHits': instance.numberOfHits,
      'timeout': instance.timeout,
    };

const _$ActivityDurationTypeEnumMap = {
  ActivityDurationType.numberOfHits: 'numberOfHits',
  ActivityDurationType.timeout: 'timeout',
  ActivityDurationType.hitsAndTimeout: 'hitsAndTimeout',
};
