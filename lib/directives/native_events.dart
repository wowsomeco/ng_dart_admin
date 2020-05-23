import 'dart:async';
import 'dart:html';
import 'package:angular/core.dart';

@Directive(selector: '[wEvent]')
class WEventBindingDirective implements OnInit {
  final Element _el;

  @Input('wEvent')
  String ev;

  @Input('stop')
  bool stop = false;

  @Input('prevent')
  bool prevent = false;

  final _listen = StreamController<Event>();
  @Output()
  Stream<Event> get wListen => _listen.stream;

  WEventBindingDirective(this._el);

  @override
  void ngOnInit() {
    _el.addEventListener(ev, (cb) {
      if (prevent) cb.preventDefault();
      if (stop) cb.stopPropagation();
      _listen.add(cb);
    });
  }
}

@Directive(selector: '[wSwipeable]')
class WSwipeableDirective implements OnInit, OnDestroy {
  final Element _el;

  bool _touching = false;

  final _swipeStart = StreamController<Point<num>>();
  @Output()
  Stream<Point<num>> get swipeStart => _swipeStart.stream;

  final _swiping = StreamController<Point<num>>();
  @Output()
  Stream<Point<num>> get swiping => _swiping.stream;

  final _swipeEnd = StreamController<Point<num>>();
  @Output()
  Stream<Point<num>> get swipeEnd => _swipeEnd.stream;

  WSwipeableDirective(this._el);

  @override
  void ngOnInit() {
    // listen to document so that it still can handle swipe outside of the elem
    ['mousedown', 'touchstart']
        .forEach((ev) => _el.addEventListener(ev, (e) => _mouseDown(e)));
    ['mousemove', 'touchmove']
        .forEach((ev) => document.addEventListener(ev, (e) => _mouseMoving(e)));
    ['mouseup', 'touchend']
        .forEach((ev) => document.addEventListener(ev, (e) => _mouseUp(e)));
  }

  @override
  void ngOnDestroy() {
    /// remove listeners on document on destroy
    ['mousedown', 'touchstart']
        .forEach((ev) => _el.removeEventListener(ev, _mouseDown));
    ['mousemove', 'touchmove']
        .forEach((ev) => document.removeEventListener(ev, _mouseMoving));
    ['mouseup', 'touchend']
        .forEach((ev) => document.removeEventListener(ev, _mouseUp));
  }

  void _mouseDown(Event e) {
    if (e is MouseEvent) e.preventDefault();
    e.stopPropagation();
    _touching = true;
    _swipeStart.add(_evToPoint(e));
  }

  void _mouseMoving(Event e) {
    if (_touching) {
      if (e is MouseEvent) e.preventDefault();
      e.stopPropagation();

      /// broadcast swiping
      _swiping.add(_evToPoint(e));
    }
  }

  void _mouseUp(Event e) {
    /// only broadcast the ev if it had received a touch before
    if (_touching) {
      e.stopPropagation();

      /// broadcast
      _swipeEnd.add(_evToPoint(e));
    }
    _touching = false;
  }

  Point<num> _evToPoint(Event e) {
    if (e is MouseEvent) return e.page;
    TouchEvent te = e as TouchEvent;
    if (te.changedTouches.isNotEmpty) return te.changedTouches[0].page;
    return te.touches[0].page;
  }
}

@Directive(selector: '[wClickOutside]')
class WClickOutsideDirective implements OnInit, OnDestroy {
  final _clickOutside = StreamController<Null>();
  @Output()
  Stream<Null> get onClickOutside => _clickOutside.stream;

  final Element _el;

  WClickOutsideDirective(this._el);

  @override
  void ngOnInit() {
    document.addEventListener('click', handleClick);
  }

  @override
  void ngOnDestroy() {
    document.removeEventListener('click', handleClick);
  }

  void handleClick(Event ev) {
    if (!_el.contains(ev.target)) _clickOutside.add(null);
  }
}
