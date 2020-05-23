import 'dart:html';
import 'package:angular/core.dart';

/// Directive that has 2 states i.e. open and closed
///
/// Can be used to build Accordion, Collapsible Menu (just like how we used it for building the nested list w-list), etc.
@Directive(selector: '[wCollapsible]')
class WCollapsibleDirective implements AfterContentInit {
  final Element _el;
  bool _showing = true;

  @Input('disabled')
  bool disabled = false;

  @Input()
  set expanded(bool flag) => _show(flag);

  WCollapsibleDirective(this._el);

  @ContentChild('collapsibleItem')
  Element collapsible;

  @override
  void ngAfterContentInit() {
    _el.onClick.listen((ev) {
      _show(!_showing);
      ev.stopPropagation();
    });
  }

  void _show(bool flag) {
    if (disabled) return;

    _showing = flag;
    if (collapsible != null) {
      collapsible.style.display = _showing ? 'block' : 'none';
    }
  }
}
