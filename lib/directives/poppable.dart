import 'dart:async';
import 'dart:html';
import 'package:angular/core.dart';
import 'package:ng_admin/interops/index.dart';

/// Popup Directive.
/// uses popper js underneath to show the pop up.
/// for more details of how to use it, refer to how the options are shown in [WSelectComponent]
/// for more details about the Input below, check out the popper docs in https://popper.js.org/docs/v2
@Directive(selector: '[wPopup]')
class WPoppableDirective implements OnInit, OnDestroy {
  /// the placement of the pop up.
  ///
  /// auto | top | bottom | right | left
  /// combine any of the above with either suffix -start or -end
  @Input('placement')
  String placement = 'bottom';

  /// The placement offset [x,y]
  @Input('offset')
  List<num> offset = [0, 0];

  /// Describes the positioning strategy to use.
  ///
  /// By default, it is absolute, which in the simplest cases does not require repositioning of the popper.
  /// absolute | fixed
  @Input('strategy')
  String strategy = 'absolute';

  /// Determines how it should show, either on click OR hover.
  ///
  /// click | hover
  @Input('popOn')
  String popOn = 'click';

  @Input('show')
  set show(bool flag) {
    _showing = flag;
    if (_showing) {
      _popper = Popper.createPopper(
          _el.parent,
          _el,
          PopperConfig(
              placement: placement,
              strategy: strategy,
              modifiers: PopperModifier(
                  offset: offset,
                  flip: PopperFlip(enabled: true),
                  preventOverflow: PopperPreventOverflow())));
      _el.style.width = '${_el.parent.getBoundingClientRect().width}px';
    } else {
      _popper?.destroy();
    }
    _el.style.display = _showing ? 'block' : 'none';
  }

  final _showChange = StreamController<bool>();
  @Output()
  Stream<bool> get showChange => _showChange.stream;

  final Element _el;
  PopperInstance _popper;
  bool _showing = false;

  /// constructor
  WPoppableDirective(this._el) {
    /// handle esc
    document.on['keydown']
        .where((ev) => ev is KeyboardEvent)
        .map((ev) => ev as KeyboardEvent)
        .where((ev) => ev.keyCode == KeyCode.ESC)
        .listen((ev) => _showChange.add(false));
  }

  @override
  void ngOnInit() {
    if (popOn == 'click') {
      _el.parent.addEventListener('click', (ev) => _toggle());
    } else {
      ['mouseover']
          .forEach((ev) => _el.parent.addEventListener(ev, (e) => _show()));
      ['mouseout']
          .forEach((ev) => _el.parent.addEventListener(ev, (e) => _hide()));
    }
  }

  @override
  void ngOnDestroy() {
    // destroy popper if not null
    _popper?.destroy();
    // remove event listener(s)
    if (popOn == 'click') {
      _el.parent.removeEventListener('click', (ev) => _toggle());
    } else {
      ['mouseover']
          .forEach((ev) => _el.parent.removeEventListener(ev, (e) => _show()));
      ['mouseout']
          .forEach((ev) => _el.parent.removeEventListener(ev, (e) => _hide()));
    }
  }

  void _show() => _showChange.add(true);

  void _hide() => _showChange.add(false);

  void _toggle() => _showChange.add(!_showing);
}
