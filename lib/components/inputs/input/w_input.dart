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
  @ViewChild('input')
  HtmlElement input;

  final WInputDecorService _service;

  WInputComponent(this._service) {
    _service.focus.listen((ev) => ev ? input.focus() : input.blur());
  }
}
