import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class _TableData implements WTableItem {
  int id;
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

List<_TableData> tableItems2 = [
  _TableData(1, name: 'Klopp', position: 'Midfielder', age: 30),
  _TableData(2, name: 'Ancelotti', position: 'Forward', age: 30),
  _TableData(3, name: 'Rivaldo', position: 'Midfielder', age: 30),
  _TableData(4, name: 'Romario', position: 'Forward', age: 30),
  _TableData(5, name: 'Ronaldo', position: 'Forward', age: 30),
  _TableData(6, name: 'Coutinho', position: 'Forward', age: 30),
  _TableData(7, name: 'Neymar', position: 'Forward', age: 30),
  _TableData(8, name: 'Saviola', position: 'Forward', age: 30),
  _TableData(9, name: 'Cristiano Ronaldo', position: 'Forward', age: 30),
];

@Component(
  selector: 'table2',
  templateUrl: 'table2.html',
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
    WDialogComponent,
    WInputComponent,
    WSelectComponent,
    WTableComponent,
    WButtonComponent
  ],
)
class Table2Component {
  bool showDialog = false;
  bool newForm = false;
  List<WSelectOption<String>> posOptions = [
    WSelectOption('Defender', 'Defender'),
    WSelectOption('Midfielder', 'Midfielder'),
    WSelectOption('Forward', 'Forward')
  ];

  WTableAdapter tblAdapter2 = WTableAdapter(
      onDeleteItem: (itm) async {
        if (window.confirm('Are you sure to delete?')) {
          tableItems2.removeAt(tableItems2.indexOf(itm));
          await Future.delayed(Duration(milliseconds: 500));
          return true;
        }
        return false;
      },
      totalSize: () async => tableItems2.length,
      fetchItems: (start, end) async {
        await Future.delayed(Duration(milliseconds: 500));
        return tableItems2.reversed
            .toList()
            .getRange(start.clamp(0, tableItems2.length),
                end.clamp(0, tableItems2.length))
            .toList();
      });

  _TableData formData = _TableData(null);

  Table2Component() {
    tblAdapter2.clickRowStream.listen((ev) => edit(ev));
  }

  void submit() {
    if (newForm) {
      formData.id = tableItems2.length;
      tableItems2.add(formData);
    } else {
      int idx = tableItems2.indexWhere((x) => x.id == formData.id);
      tableItems2[idx] = formData;
    }
    showDialog = false;
    tblAdapter2.reload();
  }

  void download() {
    XLSXWorksheet ws = XLSX.utils.json_to_sheet(tableItems2);
    XLSXWorkbook wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, 'data');
    XLSX.writeFile(wb, 'test-download.xlsx');
  }

  void add() {
    newForm = true;
    formData = _TableData(null);
    showDialog = true;
  }

  void edit(WTableItem item) {
    newForm = false;
    formData = _TableData.fromTableItem(item);
    showDialog = true;
  }
}
