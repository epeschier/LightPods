import 'package:json_annotation/json_annotation.dart';

import 'activity_enums.dart';
part 'duration_setting.g.dart';

@JsonSerializable()
class DurationSetting {
  late ActivityDurationType durationType = ActivityDurationType.timeout;
  late double numberOfHits = 10;
  late double timeout = 2;

  DurationSetting();

  factory DurationSetting.fromJson(Map<String, dynamic> json) =>
      _$DurationSettingFromJson(json);
  Map<String, dynamic> toJson() => _$DurationSettingToJson(this);

  DurationSetting copyWith(DurationSetting obj) {
    durationType = obj.durationType;
    numberOfHits = obj.numberOfHits;
    timeout = obj.timeout;

    return this;
  }
}
