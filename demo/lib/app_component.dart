import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:ng_admin/ng_admin.dart';
import 'package:ng_admin_demo/routes/index.dart';

class _SidebarItem {
  final String title;
  final String icon;
  final int level;
  final String to;

  _SidebarItem(this.title, this.icon, this.level, {this.to});
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

  Map<String, String> listMargin(int lvl) => {'margin-left': '${lvl * 5}px'};

  List<WListItem<_SidebarItem>> sidebarItems = [
    WListItem(_SidebarItem('Dashboard', 'dashboard', 0, to: '/dashboard')),
    WListItem(_SidebarItem('Tables', 'border_all', 0, to: '/tables')),
    WListItem(
        _SidebarItem(
          'Charts',
          'bar_chart',
          0,
        ),
        children: [
          WListItem(_SidebarItem('Chartist', 'bar_chart', 1, to: '/chartist'))
        ]),
    WListItem(_SidebarItem('Maps', 'layers', 0, to: '/maps')),
    WListItem(_SidebarItem('Forms', 'event_note', 0, to: '/forms')),
    WListItem(_SidebarItem('Sliders', 'timeline', 0, to: '/sliders')),
    WListItem(_SidebarItem('Tabs', 'tab', 0, to: '/tabs')),
    WListItem(_SidebarItem('Lists', 'list', 0, to: '/lists')),
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
          'bg-black-60': _router.current.path == to,
          'b': _router.current.path == to,
          'white': _router.current.path == to,
          'blue': _router.current.path != to,
        }
      : {};

  void navigate(String to) {
    if (to != null) _router.navigate(to);
  }

  void clickGithub() =>
      window.open('https://github.com/wowsomeco/ng_dart_admin', '_blank');
}
