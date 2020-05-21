import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

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
    WActionTableComponent
  ],
)
class Table2Component {
  bool _showDialog = false;

  bool get showDialog => _showDialog;
  set showDialog(bool flag) => _showDialog = flag;

  void submitForm() {
    if (newForm) {
      tableItems2.add(formData);
    } else {
      int idx = tableItems2.indexWhere((x) => x.id == formData.id);
      tableItems2[idx] = formData;
    }
    showDialog = false;
    tblAdapter2.reload();
  }

  bool newForm = false;
  _TableData formData;

  List<WSelectOption<String>> posOptions = [
    WSelectOption('Defender', 'Defender',
        (filter) => 'defender'.contains(filter.toLowerCase())),
    WSelectOption('Midfielder', 'Midfielder',
        (filter) => 'midfielder'.contains(filter.toLowerCase())),
    WSelectOption('Forward', 'Forward',
        (filter) => 'forward'.contains(filter.toLowerCase())),
  ];

  WTableAdapter tblAdapter2 = WTableAdapter(
      onDeleteItem: (itm) async {
        if (window.confirm('Are you sure to delete?')) {
          tableItems2
              .removeAt(tableItems2.indexWhere((x) => x.id == itm.tblId));
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

  WTableFormAdapter<_TableData> formAdapter =
      WTableFormAdapter<_TableData>(onSubmitForm: (f, isNew) async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (isNew) {
      tableItems2.add(f);
    } else {
      tableItems2[tableItems2.indexWhere((x) => x.tblId == f.tblId)] = f;
    }
    return true;
  }, onFetchForm: (itm) async {
    if (itm != null) {
      await Future.delayed(Duration(milliseconds: 500));
      return _TableData.fromTableItem(itm);
    }
    return _TableData(tableItems2.length + 1);
  });

  void download() {
    XLSXWorksheet ws = XLSX.utils.json_to_sheet(tableItems2);
    XLSXWorkbook wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, 'data');
    XLSX.writeFile(wb, 'test-download.xlsx');
  }
}
