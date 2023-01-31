// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distracting_colors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistractingColors _$DistractingColorsFromJson(Map<String, dynamic> json) =>
    DistractingColors()
      ..selectedColorIndex = (json['selectedColorIndex'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          []
      ..chanceToAppear = json['chanceToAppear'] as int;

Map<String, dynamic> _$DistractingColorsToJson(DistractingColors instance) =>
    <String, dynamic>{
      'selectedColorIndex': instance.selectedColorIndex,
      'chanceToAppear': instance.chanceToAppear,
    };
