import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:ng_admin/ng_admin.dart';
import 'package:ng_admin_demo/routes/index.dart';

class _SidebarItem {
  final String title;
  final int level;
  final String to;
  final String icon;

  _SidebarItem(this.title, this.level, {this.to, this.icon});
}

@Component(
    selector: 'my-app',
    styleUrls: ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: [
      coreDirectives,
      routerDirectives,
      ngAdminDirectives,
      WLayoutComponent,
      WListComponent
    ],
    exports: [RoutePaths, Routes],
    providers: [])
class AppComponent implements OnInit {
  final Router _router;

  Map<String, String> listMargin(int lvl) => {'margin-left': '${lvl * 10}px'};

  List<WListItem<_SidebarItem>> sidebarItems = [
    WListItem(
        _SidebarItem('Dashboard', 0, to: '/dashboard', icon: 'dashboard')),
    WListItem(_SidebarItem('Layouts', 0, to: '/layouts', icon: 'apps')),
    WListItem(_SidebarItem('Tables', 0, to: '/tables', icon: 'border_all')),
    WListItem(_SidebarItem('Chartist', 0, to: '/chartist', icon: 'bar_chart')),
    WListItem(_SidebarItem('Frappe', 0, to: '/frappe', icon: 'bar_chart')),
    WListItem(_SidebarItem('Maps', 0, to: '/maps', icon: 'layers')),
    WListItem(_SidebarItem('Forms', 0, to: '/forms', icon: 'event_note')),
    WListItem(_SidebarItem('Sliders', 0, to: '/sliders', icon: 'timeline')),
    WListItem(_SidebarItem('Tabs', 0, to: '/tabs', icon: 'tab')),
    WListItem(_SidebarItem('Lists', 0, to: '/lists', icon: 'list')),
    WListItem(
        _SidebarItem('Calendar', 0, to: '/calendars', icon: 'calendar_today')),
  ];

  AppComponent(this._router);

  @override
  void ngOnInit() async {
    /// might want to showcase navigate to login page if not logged in yet later
    /// it auto redirects to dashboard page for now
    await _router.navigate(RoutePaths.dashboard.toUrl());
  }

  List<String> get activeClass => ['bg-light-blue', 'b', 'dark-blue'];

  Map<String, bool> routeClass(String to) => _router.current != null
      ? {
          'bg-dark-blue': _router.current.path == to,
          'b': _router.current.path == to,
          'white': _router.current.path == to,
          'navy': to == null,
          'blue': to != null && _router.current.path != to,
        }
      : {};

  void navigate(String to) {
    if (to != null) _router.navigate(to);
  }

  void clickGithub() =>
      window.open('https://github.com/wowsomeco/ng_dart_admin', '_blank');
}
