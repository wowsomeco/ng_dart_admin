import 'dart:async';

import 'package:angular/angular.dart';
import 'package:ng_admin/components/index.dart';
import 'package:ng_admin/directives/index.dart';

abstract class TableItem {
  int get tblId;
  Map<String, dynamic> get tblRow;
}

class TableAdapter {
  int pageSize;
  Future<int> Function() totalSize;
  Future<List<TableItem>> Function(int, int) fetchItems;
  Future<bool> Function(TableItem) onDeleteItem;

  TableAdapter(
      {this.pageSize = 5, this.totalSize, this.fetchItems, this.onDeleteItem});

  final _reload = StreamController<Null>.broadcast();
  Stream<Null> get reloadStream => _reload.stream;
  void reload() => _reload.add(null);

  final _addItem = StreamController<Null>.broadcast();
  Stream<Null> get addItemStream => _addItem.stream;
  void onAddItem() => _addItem.add(null);

  final _clickRow = StreamController<TableItem>.broadcast();
  Stream<TableItem> get clickRowStream => _clickRow.stream;
  void onClickRow(TableItem itm) => _clickRow.add(itm);

  bool get canAddItem => _addItem.hasListener;
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
  bool loading = true;
  List<TableItem> items = [];
  int totalSize;

  @Input('title')
  String title;

  @Input('adapter')
  TableAdapter adapter;

  Iterable<String> get headerItem =>
      items.isNotEmpty ? items.first.tblRow.keys : null;

  int get pageSize => adapter.pageSize;

  int get pageCount => (totalSize / pageSize).ceil();

  int get pageStart => (page - 1) * pageSize;

  int get pageEnd => pageStart + pageSize;

  bool get showActionHeader => adapter.onDeleteItem != null;

  void onPageChange(int idx) {
    page = idx;
    fetchItems();
  }

  void onDeleteItem(TableItem itm) async {
    bool deleted = await adapter.onDeleteItem(itm);
    if (deleted) fetchItems();
  }

  void fetchItems() async {
    loading = true;
    items = await adapter.fetchItems(pageStart, pageEnd);
    totalSize = await adapter.totalSize();

    /// anticipates where the current page is not the first one AND
    /// apparently there are no items, then force back to first index if so
    if (page > 1 && items.isEmpty && totalSize > 0) onPageChange(1);
    loading = false;
  }

  @override
  void ngOnInit() async {
    assert(adapter != null, 'input [adapter] cannot be null');
    await fetchItems();
    adapter.reloadStream.listen((ev) => fetchItems());
  }
}
