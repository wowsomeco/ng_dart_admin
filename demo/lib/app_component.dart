import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:ng_admin/components/index.dart';
import 'package:ng_admin_demo/routes/index.dart';

class _SidebarItem {
  final String title;
  final String to;
  final String icon;

  _SidebarItem(this.title, this.to, this.icon);
}

@Component(
    selector: 'my-app',
    styleUrls: ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: [coreDirectives, routerDirectives, LayoutComponent],
    exports: [RoutePaths, Routes],
    providers: [])
class AppComponent implements OnInit {
  final Router _router;

  final List<_SidebarItem> sidebarItems = [
    _SidebarItem('Dashboard', '/dashboard', 'dashboard'),
    _SidebarItem('Charts', '/charts', 'bar_chart'),
    _SidebarItem('Maps', '/maps', 'layers'),
  ];

  AppComponent(this._router);

  @override
  void ngOnInit() async {
    /// might want to showcase navigate to login page if not logged in yet later
    /// it auto redirects to dashboard page for now
    await _router.navigate(RoutePaths.dashboard.toUrl());
  }

  List<String> get activeClass => ['bg-light-gray', 'b'];
}
