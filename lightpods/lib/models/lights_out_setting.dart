import 'package:json_annotation/json_annotation.dart';

import 'activity_enums.dart';

part 'lights_out_setting.g.dart';

@JsonSerializable()
class LightsOutSetting {
  late LightsOutType lightsOut = LightsOutType.hit;
  late double timeout = 2;

  LightsOutSetting();

  factory LightsOutSetting.fromJson(Map<String, dynamic> json) =>
      _$LightsOutSettingFromJson(json);
  Map<String, dynamic> toJson() => _$LightsOutSettingToJson(this);

  LightsOutSetting copyWith(LightsOutSetting value) {
    lightsOut = value.lightsOut;
    timeout = value.timeout;

    return this;
  }
}
