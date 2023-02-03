import 'dart:math';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:lightpods/models/pod_colors.dart';

part 'player_color.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerColor {
  List<int> selectedColorIndex = [];

  PlayerColor();

  Color getRandomColor() {
    var index = Random().nextInt(selectedColorIndex.length);
    return PodColorService.hitColors.getColor(selectedColorIndex[index]);
  }

  List<Color> getColors() => PodColorService.hitColors
      .getColorsFromIndexes(selectedColorIndex)
      .toList();

  factory PlayerColor.fromJson(Map<String, dynamic> json) =>
      _$PlayerColorFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerColorToJson(this);

  PlayerColor copyWith(PlayerColor obj) {
    selectedColorIndex = obj.selectedColorIndex;

    return this;
  }
}
