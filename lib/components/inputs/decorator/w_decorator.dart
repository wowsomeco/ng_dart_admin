import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

@Injectable()
class WInputDecorService {
  bool _focused = false;
  bool get focused => _focused;
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
  void clear() {
    _onClear.add(null);
    setFocus(false);
  }

  bool _loading = false;
  final _loadingStream = StreamController<bool>.broadcast();
  Stream<bool> get loading => _loadingStream.stream;
  void setLoading(bool flag) {
    _loading = flag;
    _loadingStream.add(_loading);
  }

  bool get isLoading => _loading;
}

@Component(
    selector: 'w-input-decor',
    templateUrl: 'w_decorator.html',
    directives: [
      coreDirectives,
      formDirectives,
      ngAdminDirectives,
      WSpinnerComponent
    ])
class WInputDecoratorComponent implements AfterViewInit {
  /// if true will show the delete icon that will broadcast clear event on click.
  @Input('clearable')
  bool clearable = false;

  /// height in px.
  @Input('height')
  int height = 40;

  @ViewChild('outer')
  HtmlElement outer;

  final WInputDecorService _service;

  WInputDecoratorComponent(this._service);

  @override
  void ngAfterViewInit() {
    _service.focus.listen((ev) {
      outer.classes.remove(ev ? 'b--moon-gray' : 'b--light-blue');
      outer.classes.add(ev ? 'b--light-blue' : 'b--moon-gray');
    });
  }

  void clear() => _service.clear();

  bool get loading => _service.isLoading;
}
