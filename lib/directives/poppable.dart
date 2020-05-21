import 'dart:async';
import 'dart:html';
import 'package:angular/core.dart';
import 'package:ng_admin/interops/index.dart';

@Directive(selector: '[wPopup]')
class PoppableDirective implements OnInit, OnDestroy {
  @Input('placement')
  String placement = 'bottom';

  @Input('show')
  set show(bool flag) {
    _showing = flag;
    if (_showing) {
      _popper = Popper.createPopper(
          _el.parent,
          _el,
          PopperConfig(
              placement: placement,
              modifiers: PopperModifier(
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
  PoppableDirective(this._el) {
    /// handle esc
    document.onKeyDown
        .where((ev) => ev.keyCode == KeyCode.ESC)
        .listen((ev) => _showChange.add(false));
  }

  @override
  void ngOnInit() =>
      _el.parent.addEventListener('click', (event) => _showChange.add(true));

  @override
  void ngOnDestroy() => _popper?.destroy();
}
