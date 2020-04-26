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
  @Input('popPlacement')
  String placement = 'bottomCenter';

  @Input('popOffsetX')
  int offsetX = 0;

  @Input('popOffsetY')
  int offsetY = 0;

  @Input('popOn')
  String popOn = 'click';

  @ContentChild('popup')
  Element popup;

  final Element _el;
  final PoppableService _service;
  final Map<String, List<double>> _placementMap = {
    'topLeft': [0, -1, 0, 0],
    'topRight': [-1, -1, 1, 0],
    'topCenter': [-0.5, -1, 0.5, 0],
    'bottomLeft': [0, 0, 0, 1],
    'bottomRight': [-1, 0, 1, 1],
    'bottomCenter': [-0.5, 0, 0.5, 1],
    'left': [-1, -0.5, 0, 0.5],
    'right': [0, -0.5, 1, 0.5]
  };

  void show(bool flag) {
    popup.style.display = flag ? 'block' : 'none';

    /// reposition on show
    if (flag) {
      Rectangle<num> elRect = _el.getBoundingClientRect();
      Rectangle<num> popupRect = popup.getBoundingClientRect();

      /// get the offset according to the placement
      List<double> offset = _placementMap[placement];

      /// calculate the offsets accordingly
      num offX =
          popupRect.width * offset[0] + elRect.width * offset[2] + offsetX;
      num offY =
          popupRect.height * offset[1] + elRect.height * offset[3] + offsetY;

      /// set pos of the popup
      popup.style.left = '${offX}px';
      popup.style.top = '${offY}px';
    }
  }

  PoppableDirective(this._service, this._el) {
    _el.style.position = 'relative';
    _service.show.listen((ev) => show(ev));
  }

  @override
  void ngAfterContentInit() {
    popup.style.position = 'absolute';

    /// hide initially
    _service.setShow(false);

    /// handle esc
    document.onKeyDown
        .where((ev) => ev.keyCode == KeyCode.ESC)
        .listen((ev) => _service.setShow(false));

    /// bind ev
    if (popOn == 'hover') {
      _el.addEventListener('mouseover', (ev) => _service.toggleShow());
      _el.addEventListener('mouseout', (ev) => _service.setShow(false));
    }

    /// it's a click
    else {
      _el.addEventListener('click', (ev) => _service.toggleShow());
    }
  }
}
