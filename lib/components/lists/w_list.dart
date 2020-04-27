import 'package:angular/angular.dart';

class WListItem {
  final String title;
  final List<WListItem> children;

  WListItem(this.title, {this.children = const []});
}

@Component(
  selector: 'w-list',
  templateUrl: 'w_list.html',
  directives: [coreDirectives],
)
class WListComponent {
  @Input('list')
  List<WListItem> list;
}
