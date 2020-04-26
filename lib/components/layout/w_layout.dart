import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

/// The default layout for ng_admin.
/// It consists of 3 sections i.e w-header, w-sidebar, and w-main
@Component(
    selector: 'w-layout',
    templateUrl: 'w_layout.html',
    directives: [coreDirectives, routerDirectives],
    exports: [],
    providers: [])
class WLayoutComponent {
  bool collapsed = false;
}
