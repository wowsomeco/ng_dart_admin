@JS()
library tippy_interop;

import 'dart:html';
import 'package:angular/core.dart';
import 'package:js/js.dart';

@JS()
external Function(Element el, TippyConfig config) get tippy;

@anonymous
@JS()
class TippyConfig {
  external String get content;
  external String get placement;

  external factory TippyConfig({String content, String placement});
}

@Directive(selector: '[wTippy]')
class TippyDirective implements AfterChanges {
  final Element _el;

  @Input('tipContent')
  String content;

  @Input('tipPlacement')
  String placement = 'bottom';

  TippyDirective(this._el);

  @override
  void ngAfterChanges() {
    tippy(_el, TippyConfig(content: content, placement: placement));
  }
}
