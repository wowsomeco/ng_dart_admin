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
  external String get trigger;
  external bool get allowHTML;

  external factory TippyConfig(
      {String content, String placement, String trigger, bool allowHTML});
}

@Directive(selector: '[wTippy]')
class TippyDirective implements AfterChanges {
  final Element _el;

  @Input('tipContent')
  String content;

  @Input('tipPlacement')
  String placement = 'bottom';

  /// mousenter,focus,click
  @Input('tipTrigger')
  String trigger = 'mouseenter focus';

  TippyDirective(this._el);

  @override
  void ngAfterChanges() {
    tippy(_el,
        TippyConfig(content: content, placement: placement, trigger: trigger));
  }
}
