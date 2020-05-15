import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';
import 'chain_select.dart';

@Component(selector: 'form3', templateUrl: 'form3.html', directives: [
  coreDirectives,
  formDirectives,
  ngAdminDirectives,
  WInputComponent,
  ChainSelectComponent
])
class Form3Component {
  String name;
  int selected1;
  int selected2;
}
