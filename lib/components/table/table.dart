import 'dart:async';

import 'package:angular/angular.dart';
import '../loader/loader.dart';
import '../pagination/pagination.dart';

class TableItem {
  final Map<String, dynamic> kv;
  Iterable<dynamic> get values => kv.values;

  TableItem(this.kv);
}

abstract class TableDataProvider {
  int get pageSize => 5;

  Future<List<TableItem>> tableItems(int start, int end);

  int get collectionSize;
}

@Component(
  selector: 'w-table',
  templateUrl: 'table.html',
  directives: [coreDirectives, LoaderComponent, PaginationComponent],
)
class TableComponent implements OnInit {
  int page = 1;
  bool loading;
  List<TableItem> items = [];

  @Input('title')
  String title;

  @Input('dataProvider')
  TableDataProvider dataProvider;

  final _addItem = StreamController<Null>();
  @Output()
  Stream<Null> get onAddItem => _addItem.stream;
  void addItem() => _addItem.add(null);

  Iterable<String> get headerItem => items.first.kv.keys;

  int get pageSize => dataProvider.pageSize;

  int get totalSize => dataProvider.collectionSize;

  int get pageCount => (totalSize / pageSize).ceil();

  int get pageStart => (page - 1) * pageSize;

  int get pageEnd => pageStart + pageSize;

  void onPageChange(int idx) {
    page = idx;
    fetchItems();
  }

  void fetchItems() async {
    loading = true;
    items = await dataProvider.tableItems(pageStart, pageEnd);
    loading = false;
  }

  @override
  void ngOnInit() async {
    await fetchItems();
  }
}
