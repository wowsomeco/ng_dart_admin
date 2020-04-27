import 'dart:html';
import 'package:angular/core.dart';

@Directive(selector: '[wCollapsible]')
class CollapsibleDirective implements AfterContentInit {
  final Element _el;
  bool _showing = false;

  CollapsibleDirective(this._el);

  @ContentChild('collapsibleItem')
  Element collapsible;

  @override
  void ngAfterContentInit() {
    _show(false);
    _el.onClick.listen((ev) {
      _show(!_showing);
      ev.stopPropagation();
    });
  }

  void _show(bool flag) {
    _showing = flag;
    if (collapsible != null) {
      collapsible.style.display = _showing ? 'block' : 'none';
    }
  }
}
