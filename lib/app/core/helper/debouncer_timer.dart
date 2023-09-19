import 'dart:async';
import 'dart:ui';

class Debouncer {
  Duration delay;
  Timer? timer;
  VoidCallback? callback;

  Debouncer(this.delay);

  void debounce(VoidCallback callback) {
    this.callback = callback;

    if (timer != null) cancel();

    timer = Timer(delay, flush);
  }

  void cancel() {
    timer!.cancel();
  }

  void flush() {
    callback!();
    cancel();
  }
}
