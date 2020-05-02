import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';
import 'tab1.dart';
import 'nested_tab.dart';

@Component(selector: 'tabs', templateUrl: 'tabs.html', directives: [
  coreDirectives,
  formDirectives,
  ngAdminDirectives,
  Tab1Component,
  NestedTabComponent
])
class TabsComponent {}
