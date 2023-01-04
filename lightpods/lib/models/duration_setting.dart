import 'activity_enums.dart';

class DurationSetting {
  late ActivityDurationType durationType = ActivityDurationType.timeout;
  late double numberOfHits = 10;
  late double timeout = 2;

  DurationSetting copyWith(DurationSetting obj) {
    durationType = obj.durationType;
    numberOfHits = obj.numberOfHits;
    timeout = obj.timeout;

    return this;
  }
}
