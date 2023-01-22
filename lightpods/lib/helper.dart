import 'dart:math';

abstract class Helper {
  static double roundDouble(double value, int places) {
    var mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  static String getTimeMmSsMs(double value) {
    var ms = _getTimeMs(value);
    var mmss = getTimeMmSs(value);
    return '$mmss.$ms';
  }

  static String getTimeMmSs(double value) {
    var sec = value.truncate();
    var mm = (sec / 60).truncate();
    var ss = sec % 60;
    return '${mm.toString().padLeft(2, '0')}:${ss.toString().padLeft(2, '0')}';
  }

  static String _getTimeMs(double value) {
    var ms = (value * 10) % 10;
    return ms.toInt().toString();
  }
}
