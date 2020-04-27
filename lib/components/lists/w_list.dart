import 'package:angular/angular.dart';

class WListItem<T> {
  final T data;
  final List<WListItem> children;

  WListItem(this.data, {this.children = const []});
}

@Component(
  selector: 'w-list',
  templateUrl: 'w_list.html',
  directives: [coreDirectives],
)
class WListComponent {
  @ContentChild(TemplateRef)
  TemplateRef listItem;

  @Input('list')
  List<WListItem> list;
}
