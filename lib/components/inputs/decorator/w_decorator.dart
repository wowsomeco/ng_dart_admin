import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(
    selector: 'w-input-decor',
    templateUrl: 'w_decorator.html',
    directives: [coreDirectives, formDirectives, ngAdminDirectives])
class WInputDecoratorComponent implements OnInit {
  final Element _el;

  final _onFocus = StreamController<bool>();
  @Output()
  Stream<bool> get focusChange => _onFocus.stream;
  void _setFocus(bool flag) {
    _el.style.outline = 'none';
    // _onFocus.add(flag);
    print(flag);
  }

  WInputDecoratorComponent(this._el);

  @override
  void ngOnInit() {
    _el.addEventListener('focusin', (ev) => _setFocus(true));
    _el.addEventListener('focusout', (ev) => _setFocus(false));
  }
}
