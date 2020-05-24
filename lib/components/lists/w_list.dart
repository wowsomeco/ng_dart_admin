import 'package:angular/angular.dart';
import 'package:ng_admin/directives/index.dart';

class WListItem<T> {
  final T data;
  final List<WListItem> children;

  WListItem(this.data, {this.children = const []});
}

/// A very generic nested list component that the content can be supplied by the caller accordingly.
///
/// see https://ngadmin.wowsome.co/#/lists for more details of how to use it.
@Component(
  selector: 'w-list',
  templateUrl: 'w_list.html',
  directives: [coreDirectives, ngAdminDirectives],
)
class WListComponent {
  @ContentChild(TemplateRef)
  TemplateRef listItem;

  @Input('list')
  List<WListItem> list;

  @Input('expandable')
  bool expandable = true;
}
