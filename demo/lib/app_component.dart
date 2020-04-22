import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:ng_admin/components/index.dart';
import 'package:ng_admin_demo/routes/index.dart';

@Component(
    selector: 'my-app',
    styleUrls: ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: [coreDirectives, routerDirectives, HeaderComponent],
    exports: [RoutePaths, Routes],
    providers: [])
class AppComponent implements OnInit {
  final Router _router;

  final List<HeaderItem> headerItems = [
    HeaderItem(name: 'Dashboard', to: '/dashboard'),
    HeaderItem(name: 'Charts', to: '/charts'),
    HeaderItem(name: 'Maps', to: '/maps'),
  ];

  AppComponent(this._router);

  @override
  void ngOnInit() async {
    /// might want to showcase navigate to login page if not logged in yet later
    /// it auto redirects to dashboard page for now
    await _router.navigate(RoutePaths.dashboard.toUrl());
  }
}
