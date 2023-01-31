// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerColor _$PlayerColorFromJson(Map<String, dynamic> json) => PlayerColor()
  ..selectedColorIndex = (json['selectedColorIndex'] as List<dynamic>)
      .map((e) => e as int)
      .toList();

Map<String, dynamic> _$PlayerColorToJson(PlayerColor instance) =>
    <String, dynamic>{
      'selectedColorIndex': instance.selectedColorIndex,
    };
