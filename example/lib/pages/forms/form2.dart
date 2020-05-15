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
  WSelectAdapter<int> select1 = WSelectAdapter<int>(fetchOptions: () async {
    await Future.delayed(Duration(seconds: 1));
    return List.generate(10, (idx) => idx)
        .map((l) => WSelectOption<int>('Item $l', l))
        .toList();
  });

  _FormData data = _FormData();
}
