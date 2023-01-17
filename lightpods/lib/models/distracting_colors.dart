import 'package:json_annotation/json_annotation.dart';
part 'distracting_colors.g.dart';

@JsonSerializable()
class DistractingColors {
  int numberOfDistractingColors = 0;
  int chanceToAppear = 0;

  DistractingColors();

  factory DistractingColors.fromJson(Map<String, dynamic> json) =>
      _$DistractingColorsFromJson(json);
  Map<String, dynamic> toJson() => _$DistractingColorsToJson(this);

  DistractingColors copyWith(DistractingColors obj) {
    numberOfDistractingColors = obj.numberOfDistractingColors;
    chanceToAppear = obj.chanceToAppear;

    return this;
  }

  @override
  String toString() => "$numberOfDistractingColors / $chanceToAppear%";
}
