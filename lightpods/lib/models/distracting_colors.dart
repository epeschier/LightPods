import 'package:json_annotation/json_annotation.dart';
part 'distracting_colors.g.dart';

@JsonSerializable()
class DistractingColors {
  @JsonKey(defaultValue: [])
  List<int> selectedColorIndex = [];
  int chanceToAppear = 0;

  DistractingColors();

  void clear() => selectedColorIndex = [];
  int size() => selectedColorIndex.length;

  factory DistractingColors.fromJson(Map<String, dynamic> json) =>
      _$DistractingColorsFromJson(json);
  Map<String, dynamic> toJson() => _$DistractingColorsToJson(this);

  DistractingColors copyWith(DistractingColors obj) {
    selectedColorIndex = obj.selectedColorIndex;
    chanceToAppear = obj.chanceToAppear;

    return this;
  }

  @override
  String toString() => "${selectedColorIndex.length} / $chanceToAppear%";
}
