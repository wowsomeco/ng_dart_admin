class Debounce {
  bool _processing = false;

  void exec(Function callback, {int delay = 250}) async {
    if (!_processing) {
      _processing = true;
      await Future.delayed(Duration(milliseconds: delay), callback);
      _processing = false;
    }
  }
}
