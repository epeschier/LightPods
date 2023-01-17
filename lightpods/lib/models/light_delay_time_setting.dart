import 'package:json_annotation/json_annotation.dart';

import 'activity_enums.dart';
part 'light_delay_time_setting.g.dart';

@JsonSerializable()
class LightDelayTimeSetting {
  late LightDelayTimeType delayTimeType = LightDelayTimeType.random;
  late double fixedTime = 2;
  late double randomTimeMin = 1;
  late double randomTimeMax = 2;

  LightDelayTimeSetting();

  factory LightDelayTimeSetting.fromJson(Map<String, dynamic> json) =>
      _$LightDelayTimeSettingFromJson(json);
  Map<String, dynamic> toJson() => _$LightDelayTimeSettingToJson(this);

  LightDelayTimeSetting copyWith(LightDelayTimeSetting obj) {
    delayTimeType = obj.delayTimeType;
    fixedTime = obj.fixedTime;
    randomTimeMin = obj.randomTimeMin;
    randomTimeMax = obj.randomTimeMax;

    return this;
  }

  @override
  String toString() {
    if (delayTimeType == LightDelayTimeType.fixed) {
      return _getFixedValueText();
    } else if (delayTimeType == LightDelayTimeType.random) {
      return _getRandomValueText();
    }
    return '';
  }

  String _getFixedValueText() => '${fixedTime.toStringAsFixed(1)} s';
  String _getRandomValueText() =>
      '${randomTimeMin.toStringAsFixed(1)}-${randomTimeMax.toStringAsFixed(1)} s';
}
