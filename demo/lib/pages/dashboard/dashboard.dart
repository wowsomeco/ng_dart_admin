import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class OfflineTable extends TableAdapter {
  final List<TableItem> _items = [
    TableItem(1, {'Name': 'John Doe', 'Position': 'Accountant', 'Age': 20}),
    TableItem(
        2, {'Name': 'Pablo Aimar', 'Position': 'Software Engineer', 'Age': 71}),
    TableItem(3, {'Name': 'Coutinho', 'Position': 'Midfielder', 'Age': 21}),
    TableItem(4, {'Name': 'Juninho', 'Position': 'Midfielder', 'Age': 21}),
    TableItem(5, {'Name': 'Firmino', 'Position': 'Forward', 'Age': 21}),
    TableItem(6, {'Name': 'Jurgen Klopp', 'Position': 'Coach', 'Age': 21}),
  ];

  TableItem editedItem;

  @override
  int get pageSize => 3;

  @override
  Future<List<TableItem>> tableItems(int start, int end) async {
    await Future.delayed(Duration(milliseconds: 300));
    return _items.reversed
        .toList()
        .getRange(start.clamp(0, _items.length), end.clamp(0, _items.length))
        .toList();
  }

  @override
  int get collectionSize => _items.length;

  @override
  void onAddItem() {
    super.onAddItem();
    editedItem = TableItem(
        _items.length + 1, {'Name': null, 'Position': null, 'Age': null});
  }

  @override
  void onEditItem(TableItem item) {
    super.onEditItem(item);
    editedItem = TableItem(item.id, {
      'Name': item.kv['Name'],
      'Position': item.kv['Position'],
      'Age': item.kv['Age']
    });
  }

  @override
  void onSubmitItem() async {
    submit(true);
    await Future.delayed(Duration(seconds: 1));
    if (isNew) {
      _items.add(editedItem);
    } else {
      int idx = _items.indexWhere((x) => x.id == editedItem.id);
      _items[idx] = editedItem;
    }
    submit(false);
  }

  @override
  void onDeleteItem(TableItem item) async {
    print(item);
    if (window.confirm('Are you sure to delete?')) {
      submit(true);
      await Future.delayed(Duration(seconds: 1));
      _items.remove(item);
      submit(false);
    }
  }
}

class _ListData {
  final String title;
  final String icon;
  final int level;
  final List<_ListData> sub;

  _ListData(this.title, this.icon, this.level, {this.sub = const []});
}

@Component(selector: 'dashboard', templateUrl: 'dashboard.html', directives: [
  coreDirectives,
  formDirectives,
  ngAdminDirectives,
  WTableComponent,
  WDialogComponent,
  WInputComponent,
  WSpinnerComponent,
  WListComponent
], providers: [])
class DashboardComponent implements OnInit {
  List<WListItem<_ListData>> listItem2 = [
    WListItem<_ListData>(
        _ListData(
          'Item 1',
          'dashboard',
          0,
          sub: [_ListData('Child 1', 'person', 1)],
        ),
        children: [
          WListItem<_ListData>(_ListData(
            'Another',
            'emoji_people',
            0,
            sub: [_ListData('Another 1', 'party_mode', 1)],
          ))
        ]),
    WListItem<_ListData>(_ListData('Item 2', 'mood_bad', 0))
  ];

  OfflineTable tblAdapter1 = OfflineTable();

  bool submitting = false;

  TableItem get formModel => tblAdapter1.editedItem;

  void submitModel() => tblAdapter1.onSubmitItem();

  @override
  void ngOnInit() {
    tblAdapter1.submitting.listen((ev) => submitting = ev);
  }
}
