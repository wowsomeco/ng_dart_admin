import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class _FormData {
  String name;
  int age;
  int selected1;
  int selected2 = 2;
}

@Component(selector: 'form2', templateUrl: 'form2.html', directives: [
  coreDirectives,
  formDirectives,
  ngAdminDirectives,
  WSelectComponent,
  WInputComponent
])
class Form2Component {
  List<WSelectOption<int>> options = List.generate(10, (idx) => idx)
      .map((l) => WSelectOption<int>(
          'Item $l', l, (filter) => 'Item $l'.toLowerCase().contains(filter)))
      .toList();

  _FormData data = _FormData();
}
