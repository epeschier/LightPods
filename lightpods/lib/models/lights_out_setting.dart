import 'activity_enums.dart';

class LightsOutSetting {
  late LightsOutType lightsOut = LightsOutType.hit;
  late double timeout = 2;

  LightsOutSetting copyWith(LightsOutSetting value) {
    lightsOut = value.lightsOut;
    timeout = value.timeout;

    return this;
  }
}
