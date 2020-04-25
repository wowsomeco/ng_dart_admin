import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

@Injectable()
class WInputDecorService {
  bool _focused = false;
  final _onFocus = StreamController<bool>.broadcast();
  Stream<bool> get focus => _onFocus.stream;
  void setFocus(bool flag) {
    if (_focused == flag) return;
    _focused = flag;
    _onFocus.add(flag);
  }

  void toggleFocus() => setFocus(!_focused);

  final _onClear = StreamController<Null>.broadcast();
  Stream<Null> get onClear => _onClear.stream;
  void clear() => _onClear.add(null);
}

@Component(
    selector: 'w-input-decor',
    templateUrl: 'w_decorator.html',
    directives: [coreDirectives, formDirectives, ngAdminDirectives])
class WInputDecoratorComponent implements AfterViewInit, OnDestroy {
  @ViewChild('outer')
  HtmlElement outer;

  final WInputDecorService _service;

  WInputDecoratorComponent(this._service);

  @override
  void ngAfterViewInit() {
    document.addEventListener('click', handleClick);
    _service.focus.listen((ev) {
      outer.classes.remove(ev ? 'b--light-gray' : 'b--blue');
      outer.classes.add(ev ? 'b--blue' : 'b--light-gray');
    });
  }

  @override
  void ngOnDestroy() {
    document.removeEventListener('click', handleClick);
  }

  void handleClick(Event ev) {
    /// if click ev is inside the content, toggle show
    /// if click is outside, just hide the popup
    outer.contains(ev.target)
        ? _service.toggleFocus()
        : _service.setFocus(false);
  }

  void clear() => _service.clear();
}
