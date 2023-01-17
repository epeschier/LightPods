// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_delay_time_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LightDelayTimeSetting _$LightDelayTimeSettingFromJson(
        Map<String, dynamic> json) =>
    LightDelayTimeSetting()
      ..delayTimeType =
          $enumDecode(_$LightDelayTimeTypeEnumMap, json['delayTimeType'])
      ..fixedTime = (json['fixedTime'] as num).toDouble()
      ..randomTimeMin = (json['randomTimeMin'] as num).toDouble()
      ..randomTimeMax = (json['randomTimeMax'] as num).toDouble();

Map<String, dynamic> _$LightDelayTimeSettingToJson(
        LightDelayTimeSetting instance) =>
    <String, dynamic>{
      'delayTimeType': _$LightDelayTimeTypeEnumMap[instance.delayTimeType]!,
      'fixedTime': instance.fixedTime,
      'randomTimeMin': instance.randomTimeMin,
      'randomTimeMax': instance.randomTimeMax,
    };

const _$LightDelayTimeTypeEnumMap = {
  LightDelayTimeType.none: 'none',
  LightDelayTimeType.fixed: 'fixed',
  LightDelayTimeType.random: 'random',
};
