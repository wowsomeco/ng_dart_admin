import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

class _Timeline {
  final String title;
  final String icon;

  _Timeline(this.title, this.icon);
}

@Component(
    selector: 'timeline-list',
    templateUrl: 'timeline_list.html',
    directives: [coreDirectives, ngAdminDirectives, WListComponent])
class TimelineListComponent {
  List<WListItem<_Timeline>> timelines = [
    WListItem<_Timeline>(_Timeline('First', 'dashboard')),
    WListItem<_Timeline>(_Timeline('And', 'book')),
    WListItem<_Timeline>(_Timeline('Then', 'autorenew')),
    WListItem<_Timeline>(_Timeline('Done', 'done')),
  ];

  Map<String, bool> timelineClasses(bool first, bool last, bool odd) => {
        'green': last,
        'pink': first,
        'flex-row-reverse': odd,
        'blue': !first && !last
      };
}
