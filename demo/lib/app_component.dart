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

  _SidebarItem(this.title, this.icon, this.level, this.to);
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

  List<WListItem<_SidebarItem>> get sidebarItems => Routes.all
      .map((x) => WListItem<_SidebarItem>(_SidebarItem(
            '${x.path[0].toUpperCase()}${x.path.substring(1)}',
            x.additionalData['icon'],
            0,
            '/${x.path}',
          )))
      .toList();

  List<String> get topMenu => ['alarm', 'assignment', 'book', 'card_travel'];

  AppComponent(this._router);

  @override
  void ngOnInit() async {
    /// might want to showcase navigate to login page if not logged in yet later
    /// it auto redirects to dashboard page for now
    await _router.navigate(RoutePaths.dashboard.toUrl());
  }

  List<String> get activeClass => ['bg-light-blue', 'b', 'dark-blue'];

  void clickGithub() =>
      window.open('https://github.com/wowsomeco/ng_dart_admin', '_blank');
}
