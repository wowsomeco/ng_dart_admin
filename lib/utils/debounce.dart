import 'dart:async';

class Debounce {
  Timer _timer;

  void exec(Function callback, {int delay = 250}) {
    cancel();
    _timer = Timer(Duration(milliseconds: delay), () => callback());
  }

  void cancel() => _timer?.cancel();
}
