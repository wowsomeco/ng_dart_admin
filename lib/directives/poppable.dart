import 'dart:async';
import 'dart:html';
import 'package:angular/core.dart';

@Directive(selector: '[poppable]')
class PoppableDirective implements OnInit, OnDestroy {
  PoppableDirective(Element el) {
    el.style.position = 'relative';
  }

  @ContentChild(PoppableToggleDirective)
  PoppableToggleDirective toggle;

  @ContentChild(PopupDirective)
  PopupDirective popup;

  @override
  void ngOnInit() {
    document.addEventListener('click', handleClick);
    // handle esc
    document.onKeyDown
        .where((ev) => ev.keyCode == KeyCode.ESC)
        .listen((ev) => popup.showing = false);
  }

  @override
  void ngOnDestroy() {
    document.removeEventListener('click', handleClick);
  }

  bool handleClick(Event ev) {
    /// if click ev is inside the content, toggle show
    /// if click is outside, just hide the popup
    toggle.elem.contains(ev.target)
        ? popup.toggleShow()
        : popup.showing = false;
    return false;
  }
}

@Directive(selector: '[poppableToggle]')
class PoppableToggleDirective implements OnInit {
  final Element _el;

  Element get elem => _el;

  PoppableToggleDirective(this._el);

  @ContentChild(PoppableToggleDirective)
  PoppableToggleDirective toggle;

  @ContentChild(PopupDirective)
  PopupDirective popper;

  @override
  void ngOnInit() {}
}

@Directive(selector: '[popup]')
class PopupDirective implements OnInit {
  bool _showing = false;

  @Input('popupShow')
  set showing(bool flag) {
    _showing = flag;
    _el.style.display = flag ? 'block' : 'none';
    _showChanged.add(flag);
  }

  final _showChanged = StreamController<bool>();
  @Output()
  Stream<bool> get popupShowChange => _showChanged.stream;

  final Element _el;

  Element get elem => _el;

  PopupDirective(this._el) {
    _el.style.position = 'absolute';
  }

  @override
  void ngOnInit() {
    showing = false;
  }

  void toggleShow() => showing = !_showing;
}
