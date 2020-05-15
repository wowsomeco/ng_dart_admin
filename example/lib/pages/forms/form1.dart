import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(selector: 'form1', templateUrl: 'form1.html', directives: [
  coreDirectives,
  formDirectives,
  ngAdminDirectives,
  WSelectComponent,
  WInputComponent
])
class Form1Component {
  String name;
  int selected1 = 1;
  int selected2;
  int selected3;

  WSelectAdapter<int> selectAdapter =
      WSelectAdapter<int>(fetchOptions: () async {
    await Future.delayed(Duration(seconds: 1));
    return List.generate(20, (idx) => idx + 1)
        .map((l) => WSelectOption<int>('Item $l', l))
        .toList();
  });
}
