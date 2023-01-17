// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lights_out_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LightsOutSetting _$LightsOutSettingFromJson(Map<String, dynamic> json) =>
    LightsOutSetting()
      ..lightsOut = $enumDecode(_$LightsOutTypeEnumMap, json['lightsOut'])
      ..timeout = (json['timeout'] as num).toDouble();

Map<String, dynamic> _$LightsOutSettingToJson(LightsOutSetting instance) =>
    <String, dynamic>{
      'lightsOut': _$LightsOutTypeEnumMap[instance.lightsOut]!,
      'timeout': instance.timeout,
    };

const _$LightsOutTypeEnumMap = {
  LightsOutType.hit: 'hit',
  LightsOutType.timeout: 'timeout',
  LightsOutType.hitTimeout: 'hitTimeout',
};
