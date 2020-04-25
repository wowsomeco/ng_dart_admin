import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';
import 'package:ng_admin_demo/directives/mouse_event_directives.dart';

@Component(selector: 'forms', templateUrl: 'forms.html', directives: [
  coreDirectives,
  formDirectives,
  StopPropagationDirective,
  ngAdminDirectives,
  WSelectComponent,
  WInputComponent
])
class FormsComponent {
  String get cardClass => 'ba br1 b--light-gray';

  List<SelectOption<int>> options = [
    SelectOption<int>('Item 1', 1),
    SelectOption<int>('Item 2', 2),
    SelectOption<int>('Item 3', 3),
    SelectOption<int>('Item 4', 4),
    SelectOption<int>('Item 5', 5),
  ];

  SelectOption<int> selectedOption = SelectOption<int>('Item 3', 3);
}
