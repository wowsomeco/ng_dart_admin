import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

List<_TableData> tableItems1 = [
  _TableData(1, name: 'Juninho', position: 'Midfielder', age: 30),
  _TableData(2, name: 'Bebeto', position: 'Forward', age: 30),
  _TableData(3, name: 'Rivaldo', position: 'Midfielder', age: 30),
  _TableData(4, name: 'Romario', position: 'Forward', age: 30),
  _TableData(5, name: 'Ronaldo', position: 'Forward', age: 30),
  _TableData(6, name: 'Coutinho', position: 'Forward', age: 30),
  _TableData(7, name: 'Neymar', position: 'Forward', age: 30),
  _TableData(8, name: 'Saviola', position: 'Forward', age: 30),
  _TableData(9, name: 'Cristiano Ronaldo', position: 'Forward', age: 30),
];

class _TableData implements WTableItem {
  final int id;
  String name;
  String position;
  int age;

  _TableData(this.id, {this.name, this.position, this.age});

  @override
  int get tblId => id;

  @override
  Map<String, dynamic> get tblRow =>
      {'Name': name, 'Position': position, 'Age': age};

  factory _TableData.fromTableItem(WTableItem itm) => _TableData(
        itm.tblId,
        name: itm.tblRow['Name'],
        position: itm.tblRow['Position'],
        age: itm.tblRow['Age'],
      );
}

@Component(
  selector: 'table-filter',
  templateUrl: 'table_with_filter.html',
  directives: [
    coreDirectives,
    ngAdminDirectives,
    WTableComponent,
    WInputComponent
  ],
)
class TableFilterComponent implements OnInit, OnDestroy {
  String _filterName;
  String get filterName => _filterName;
  set filterName(String v) {
    _filterName = v;
    _debounce.exec(() => adapter.reload());
  }

  WTableAdapter adapter;

  final Debounce _debounce = Debounce();

  @override
  void ngOnInit() {
    adapter = WTableAdapter(
        pageSize: 3,
        totalSize: () async {
          /// fake delay loading the total size
          await Future.delayed(Duration(milliseconds: 100));
          return tableItems1.length;
        },
        fetchItems: (start, end) async {
          /// fake delay for fetching the item
          await Future.delayed(Duration(milliseconds: 500));
          return tableItems1
              .getRange(start.clamp(0, tableItems1.length),
                  end.clamp(0, tableItems1.length))
              .where((element) => filterName == null
                  ? true
                  : element.name
                      .toLowerCase()
                      .contains(filterName.toLowerCase()))
              .toList();
        });
  }

  @override
  void ngOnDestroy() {
    _debounce.cancel();
  }

  void download() {
    XLSXWorksheet ws = XLSX.utils.json_to_sheet(tableItems1);
    XLSXWorkbook wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, 'data');
    XLSX.writeFile(wb, 'test-download.xlsx');
  }
}
