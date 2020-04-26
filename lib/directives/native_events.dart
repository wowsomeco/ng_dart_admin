import 'dart:async';
import 'dart:html';
import 'package:angular/core.dart';

@Directive(selector: '[wEvent]')
class EventBindingDirective implements OnInit {
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

  EventBindingDirective(this._el);

  @override
  void ngOnInit() {
    _el.addEventListener(ev, (cb) {
      if (prevent) cb.preventDefault();
      if (stop) cb.stopPropagation();
      _listen.add(cb);
    });
  }
}
