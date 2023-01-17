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

  @override
  String toString() {
    String description = '';
    if (durationType != ActivityDurationType.timeout) {
      description += '${numberOfHits.toInt()} hits';
    }

    if (durationType == ActivityDurationType.hitsAndTimeout) {
      description += ' / ';
    }

    if (durationType != ActivityDurationType.numberOfHits) {
      description += '${timeout.toStringAsFixed(1)} min';
    }

    return description;
  }
}
