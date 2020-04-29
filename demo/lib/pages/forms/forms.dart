import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class _FormData1 {
  String name;
  int age;
}

@Component(selector: 'forms', templateUrl: 'forms.html', directives: [
  coreDirectives,
  formDirectives,
  ngAdminDirectives,
  WSelectComponent,
  WInputComponent
])
class FormsComponent {
  String get cardClass => 'ba br1 b--light-gray mv1';

  String name = 'Jonathan Bachini';

  WSelectAdapter<int> select1 = WSelectAdapter<int>(fetchOptions: () async {
    await Future.delayed(Duration(seconds: 1));
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

  int selectedOption = 7;

  _FormData1 formData1 = _FormData1();
}
