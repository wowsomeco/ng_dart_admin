import 'dart:async';
import 'dart:html';
import 'package:angular/core.dart';

@Directive(selector: '[poppable]')
class PoppableDirective implements AfterContentInit {
  bool _showing;

  @ViewChild('popup')
  Element popup;

  @Input('popShow')
  set showing(bool flag) {
    print(flag);
    _showing = flag;
    if (popup != null) {
      popup.style.display = flag ? 'block' : 'none';
    }
    _showChanged.add(flag);
  }

  final _showChanged = StreamController<bool>();
  @Output()
  Stream<bool> get popShowChange => _showChanged.stream;

  final Element _el;

  PoppableDirective(this._el) {
    _el.style.position = 'relative';
  }

  @override
  void ngAfterContentInit() {
    // print(popup);
    if (popup != null) {
      popup.style.position = 'absolute';
    }

    // handle esc
    document.onKeyDown
        .where((ev) => ev.keyCode == KeyCode.ESC)
        .listen((ev) => showing = false);
  }

  void toggleShow() => showing = !_showing;
}
