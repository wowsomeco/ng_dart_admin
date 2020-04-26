import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(
  selector: 'w-input',
  templateUrl: 'w_input.html',
  providers: [ClassProvider(WInputDecorService)],
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
    WInputDecoratorComponent
  ],
)
class WInputComponent {
  @Input('value')
  dynamic value;

  @Input('type')
  String type = 'text';

  @ViewChild('input')
  HtmlElement input;

  final _valueChange = StreamController<dynamic>();
  @Output()
  Stream<dynamic> get valueChange => _valueChange.stream;
  void setValue(dynamic v) => _valueChange.add(v);

  final WInputDecorService _service;

  WInputComponent(this._service) {
    _service.focus.listen((ev) => ev ? input.focus() : input.blur());
    _service.onClear.listen((ev) => setValue(null));
  }
}
