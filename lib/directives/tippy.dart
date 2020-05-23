@JS()
library tippy_interop;

import 'dart:html';
import 'package:angular/core.dart';
import 'package:js/js.dart';

@JS()
external TippyInterface tippy(Element el, TippyConfig config);

@anonymous
@JS()
class TippyInterface {
  external void destroy();
  external void setContent(String txt);
}

@anonymous
@JS()
class TippyConfig {
  external String get content;
  external String get placement;
  external String get trigger;
  external bool get allowHTML;
  external dynamic get followCursor;
  external bool get arrow;
  external dynamic get delay;
  external bool get hideOnClick;
  external dynamic get offset;

  external factory TippyConfig({
    String content,
    String placement,
    String trigger,
    bool allowHTML,
    dynamic followCursor = false,
    bool arrow = true,
    dynamic delay = 0,
    bool hideOnClick = true,
    dynamic offset = 0,
  });
}

/// Tippy js directive.
///
/// the props are currently partially supported.
/// Refer to this for more details regarding the props https://atomiks.github.io/tippyjs/v5/all-props/
@Directive(selector: '[wTippy]')
class TippyDirective implements OnInit, AfterChanges, OnDestroy {
  final Element _el;

  @Input('tipContent')
  String content;

  @Input('tipPlacement')
  String placement = 'bottom';

  /// mousenter,focus,click
  @Input('tipTrigger')
  String trigger = 'mouseenter focus';

  @Input('tipFollowCursor')
  dynamic followCursor = false;

  @Input('tipHideOnClick')
  bool hideOnClick = true;

  @Input('tipOffset')
  dynamic offset = 0;

  TippyInterface _tippy;

  TippyDirective(this._el);

  @override
  void ngOnInit() {
    _tippy = tippy(
        _el,
        TippyConfig(
          content: content,
          placement: placement,
          trigger: trigger,
          followCursor: followCursor,
          hideOnClick: hideOnClick,
        ));
  }

  @override
  void ngAfterChanges() {
    _tippy?.setContent(content);
  }

  @override
  void ngOnDestroy() {
    _tippy?.destroy();
  }
}
