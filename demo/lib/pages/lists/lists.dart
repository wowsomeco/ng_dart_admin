import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

class _ListData {
  final String title;
  final String icon;
  final int level;

  _ListData(this.title, this.icon, this.level);
}

@Component(
    selector: 'lists',
    templateUrl: 'lists.html',
    directives: [coreDirectives, ngAdminDirectives, WListComponent])
class ListsComponent {
  List<WListItem<_ListData>> sampleList = [
    WListItem<_ListData>(_ListData('Item 1', 'dashboard', 0), children: [
      WListItem<_ListData>(_ListData('Child 1', 'emoji_people', 0), children: [
        WListItem<_ListData>(_ListData('Grand Child 1', 'person', 2)),
        WListItem<_ListData>(_ListData('Grand Child 2', 'adb', 2)),
      ]),
      WListItem<_ListData>(_ListData('Child 2', 'wc', 1)),
      WListItem<_ListData>(_ListData('Child 3', 'party_mode', 1))
    ]),
    WListItem<_ListData>(_ListData('Item 2', 'mood_bad', 0))
  ];

  Map<String, String> listMargin(int lvl) => {'margin-left': '${lvl * 10}px'};
}
