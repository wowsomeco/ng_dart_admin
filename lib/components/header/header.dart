import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

class HeaderItem {
  final String to;
  final String name;

  HeaderItem({this.to, this.name});
}

@Component(
    selector: 'w-header',
    templateUrl: 'header.html',
    directives: [coreDirectives, routerDirectives],
    exports: [],
    providers: [])
class HeaderComponent {
  @Input()
  List<HeaderItem> items = [];

  @Input()
  String title;

  bool collapsed = true;
}
