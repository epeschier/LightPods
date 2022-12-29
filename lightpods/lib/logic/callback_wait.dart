import 'dart:async';

abstract class CallbackWait {
  Timer? timer;

  void wait(Function callback);

  void abort() {
    timer?.cancel();
  }
}
