import 'dart:html';

class KeyboardEventListener {
  /// the keyboard event e.g keydown, keyup, etc.
  final String event;

  /// e.g. KeyCode.ESC, etc.
  final List<int> keyCodes;

  /// the callback that gets triggered when any of the [keyCodes] is hit.
  final Function(KeyboardEvent) callback;

  final bool Function(Event) where;

  KeyboardEventListener(this.event, this.keyCodes, this.callback,
      {this.where}) {
    document.on[event]
        .where((ev) => ev is KeyboardEvent && (where(ev) ?? true))
        .map((ev) => ev as KeyboardEvent)
        .where((ev) => keyCodes.contains(ev.keyCode))
        .listen((ev) => callback(ev));
  }
}
