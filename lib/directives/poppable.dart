import 'dart:async';
import 'dart:html';
import 'package:angular/core.dart';

@Injectable()
class PoppableService {
  bool _show = false;
  final _onShowChange = StreamController<bool>.broadcast();
  Stream<bool> get show => _onShowChange.stream;

  void setShow(bool flag) {
    _show = flag;
    _onShowChange.add(_show);
  }

  void toggleShow() => setShow(!_show);
}

@Directive(selector: '[poppable]', providers: [ClassProvider(PoppableService)])
class PoppableDirective implements AfterContentInit {
  @Input('offsetX')
  int offsetX;

  @Input('offsetY')
  int offsetY;

  @ContentChild('popup')
  Element popup;

  final Element _el;
  final PoppableService _service;

  void show(bool flag) => popup.style.display = flag ? 'block' : 'none';

  PoppableDirective(this._service, this._el) {
    _el.style.position = 'relative';
    _el.onClick.listen((ev) => _service.toggleShow());
    _service.show.listen((ev) => show(ev));
  }

  @override
  void ngAfterContentInit() {
    popup.style.position = 'absolute';
    Rectangle<num> elRect = _el.getBoundingClientRect();
    Rectangle<num> popupRect = popup.getBoundingClientRect();
    // num offX = popupRect.left - elRect.left - (popupRect.width / 2);
    num offX = popupRect.width - elRect.width / 2;
    // num offY = popupRect.top - elRect.top;
    popup.style.transform = 'translate(-${offX}px,10px)';
    _service.setShow(false);
    // handle esc
    document.onKeyDown
        .where((ev) => ev.keyCode == KeyCode.ESC)
        .listen((ev) => _service.setShow(false));
  }
}
