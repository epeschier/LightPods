import 'package:json_annotation/json_annotation.dart';

import 'activity_enums.dart';

part 'lights_out_setting.g.dart';

@JsonSerializable()
class LightsOutSetting {
  late LightsOutType lightsOut = LightsOutType.hit;
  late double timeout = 2;

  @JsonKey(defaultValue: false)
  late bool lightsOutOnMiss = false;

  LightsOutSetting();

  factory LightsOutSetting.fromJson(Map<String, dynamic> json) =>
      _$LightsOutSettingFromJson(json);
  Map<String, dynamic> toJson() => _$LightsOutSettingToJson(this);

  LightsOutSetting copyWith(LightsOutSetting value) {
    lightsOut = value.lightsOut;
    timeout = value.timeout;
    lightsOutOnMiss = value.lightsOutOnMiss;

    return this;
  }

  @override
  String toString() {
    var text = '';
    if (lightsOut != LightsOutType.timeout) {
      text = 'hit';
    }
    if (lightsOut == LightsOutType.hitTimeout) {
      text += ' / ';
    }

    text += (lightsOut.index > 0) ? '${timeout.toStringAsFixed(1)} s' : '';
    return text;
  }
}
