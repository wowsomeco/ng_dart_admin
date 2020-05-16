import 'dart:async';
import 'dart:html';
import 'package:angular/core.dart';

@Directive(selector: '[wPopup]')
class PoppableDirective implements OnInit, OnDestroy {
  @Input('show')
  set show(bool flag) {
    _showing = flag;
    _el.style.display = flag ? 'block' : 'none';
    _setPos();
    _showChange.add(flag);
    _timer?.cancel();

    /// when showing, a new timer will be created
    /// used for checking the y coord of the content
    /// if it changes (normally happens when it's currently scrolling),
    /// it will force hide the content.
    if (flag) {
      _curPosY = _parentRect.top.toInt();
      _timer = Timer.periodic(Duration(milliseconds: 100), (t) {
        if (_curPosY != _parentRect.top.toInt()) show = false;
        if (_curHeight != _elRect.height) _setPos();
      });
    }
  }

  final _showChange = StreamController<bool>();
  @Output()
  Stream<bool> get showChange => _showChange.stream;

  final Element _el;
  int _curPosY;
  int _curHeight;
  bool _showing = false;
  Element _parent;
  Timer _timer;

  Rectangle<num> get _parentRect => _parent.getBoundingClientRect();
  Rectangle<num> get _elRect => _el.getBoundingClientRect();

  /// constructor
  PoppableDirective(this._el);

  @override
  void ngOnInit() async {
    _parent = _el.parent;

    /// set element at last of the body
    document.body.append(_el);
    _el.style.position = 'absolute';

    /// hide initially
    show = false;

    /// handle esc
    document.onKeyDown
        .where((ev) => ev.keyCode == KeyCode.ESC)
        .listen((ev) => show = false);

    ['resize', 'orientationchange']
        .forEach((ev) => window.addEventListener(ev, (e) => _setPos()));
  }

  @override
  void ngOnDestroy() {
    _timer?.cancel();

    ['resize', 'orientationchange']
        .forEach((ev) => window.removeEventListener(ev, (e) => _setPos()));
  }

  void _setPos() {
    if (!_showing) return;

    _curHeight = _elRect.height;

    num offX = _parent.offsetLeft;
    num offY = _parentRect.top + _parentRect.height;
    // check if the popup is cut off at the bottom
    // if so, place the popup above the parent el.
    if (offY + _curHeight > window.innerHeight) {
      offY = _parentRect.top - _curHeight;
    }

    /// set pos of the popup
    _el.style.left = '${offX}px';
    _el.style.top = '${offY}px';
    _el.style.width = '${_parentRect.width}px';
  }
}
