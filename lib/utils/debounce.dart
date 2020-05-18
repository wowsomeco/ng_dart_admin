import 'dart:async';

class Debounce {
  bool _processing = false;
  Timer _timer;

  void exec(Function callback, {int delay = 250}) async {
    if (!_processing) {
      _processing = true;
      _timer = Timer(Duration(milliseconds: delay), () {
        _processing = false;
        callback();
      });
    }
  }

  void cancel() => _timer?.cancel();
}
