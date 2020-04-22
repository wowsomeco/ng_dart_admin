import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

class SidebarItem {
  final String title;
  final String icon;
  final List<SidebarItem> contents;

  SidebarItem(this.title, {this.icon, this.contents = const []});
}

@Component(
    selector: 'w-sidebar',
    templateUrl: 'sidebar.html',
    directives: [coreDirectives, routerDirectives],
    exports: [],
    providers: [])
class SidebarComponent {
  @Input()
  List<SidebarItem> items = [];
}
