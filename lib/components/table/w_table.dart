import 'dart:async';

import 'package:angular/angular.dart';
import 'package:ng_admin/components/index.dart';
import 'package:ng_admin/directives/index.dart';

class TableItem {
  final int id;
  final Map<String, dynamic> kv;
  Iterable<dynamic> get values => kv.values;

  TableItem(this.id, this.kv);
}

abstract class TableAdapter {
  bool isNew;

  int get pageSize => 5;
  Future<List<TableItem>> tableItems(int start, int end);
  int get collectionSize;

  final _submitting = StreamController<bool>.broadcast();
  @Output()
  Stream<bool> get submitting => _submitting.stream;
  void submit(bool flag) => _submitting.add(flag);

  void onAddItem() => isNew = true;

  void onEditItem(TableItem item) => isNew = false;

  void onSubmitItem();

  void onDeleteItem(TableItem item);
}

@Component(
  selector: 'w-table',
  templateUrl: 'w_table.html',
  directives: [
    coreDirectives,
    ngAdminDirectives,
    WPaginationComponent,
    WSpinnerComponent,
    WDialogComponent
  ],
)
class WTableComponent implements OnInit {
  int page = 1;
  bool loading = false;
  bool dialog = false;
  List<TableItem> items = [];

  @Input('title')
  String title;

  @Input('adapter')
  TableAdapter adapter;

  void addItem() {
    dialog = true;
    adapter.onAddItem();
  }

  void editItem(TableItem item) {
    dialog = true;
    adapter.onEditItem(item);
  }

  Iterable<String> get headerItem => items.first.kv.keys;

  int get pageSize => adapter.pageSize;

  int get totalSize => adapter.collectionSize;

  int get pageCount => (totalSize / pageSize).ceil();

  int get pageStart => (page - 1) * pageSize;

  int get pageEnd => pageStart + pageSize;

  void onPageChange(int idx) {
    page = idx;
    fetchItems();
  }

  void fetchItems() async {
    loading = true;
    items = await adapter.tableItems(pageStart, pageEnd);
    loading = false;
  }

  @override
  void ngOnInit() async {
    await fetchItems();
    adapter.submitting.listen((ev) {
      if (!ev) {
        dialog = false;
        fetchItems();
      }
    });
  }
}
