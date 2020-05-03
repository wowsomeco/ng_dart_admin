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
  int selected;

  WSelectAdapter<int> select1 = WSelectAdapter<int>(fetchOptions: () async {
    return [
      WSelectOption<int>('Item 1', 1),
      WSelectOption<int>('Item 2', 2),
      WSelectOption<int>('Item 3', 3),
      WSelectOption<int>('Item 4', 4),
      WSelectOption<int>('Item 5', 5),
      WSelectOption<int>('Item 6', 6),
      WSelectOption<int>('Item 7', 7),
    ];
  });
}
