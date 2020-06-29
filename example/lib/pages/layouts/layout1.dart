import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

class _SidebarItem {
  final String title;
  final String icon;
  bool active;

  _SidebarItem(this.title, this.icon, {this.active = false});
}

@Component(selector: 'layout1', templateUrl: 'layout1.html', directives: [
  coreDirectives,
  ngAdminDirectives,
  WLayoutComponent,
  WListComponent
])
class Layout1Component {
  int active = 0;

  List<WListItem<_SidebarItem>> sidebarItems = [
    WListItem(_SidebarItem('Item 1', 'dashboard')),
    WListItem(_SidebarItem('Item 2', 'border_all')),
    WListItem(_SidebarItem('Item 3', 'bar_chart')),
    WListItem(_SidebarItem('Item 4', 'person')),
  ];

  Map<String, bool> itemClass(int idx) =>
      {'light-blue b': active == idx, 'silver': active != idx};
}
