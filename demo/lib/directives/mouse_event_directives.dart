import 'dart:html';
import 'package:angular/core.dart';

@Directive(selector: '[clickStop]')
class StopPropagationDirective {
  final Element _el;

  StopPropagationDirective(this._el) {
    _el.onClick.listen((ev) => ev.stopPropagation());
  }
}
