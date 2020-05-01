import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';
import 'nested_list.dart';
import 'timeline_list.dart';

@Component(selector: 'lists', templateUrl: 'lists.html', directives: [
  coreDirectives,
  ngAdminDirectives,
  NestedListComponent,
  TimelineListComponent
])
class ListsComponent {}
