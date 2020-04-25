import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(
  selector: 'w-input',
  templateUrl: 'w_input.html',
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

  void onFocus(bool flag) => flag ? input.focus() : input.blur();
}
