import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class _TableData1 implements WTableItem {
  final int id;
  String name;
  String position;
  int age;

  _TableData1(this.id, {this.name, this.position, this.age});

  @override
  int get tblId => id;

  @override
  Map<String, dynamic> get tblRow =>
      {'Name': name, 'Position': position, 'Age': age};

  factory _TableData1.fromTableItem(WTableItem itm) => _TableData1(
        itm.tblId,
        name: itm.tblRow['Name'],
        position: itm.tblRow['Position'],
        age: itm.tblRow['Age'],
      );
}

List<_TableData1> tableItems1 = [
  _TableData1(1, name: 'Juninho', position: 'Midfielder', age: 30),
  _TableData1(2, name: 'Bebeto', position: 'Forward', age: 30),
  _TableData1(3, name: 'Rivaldo', position: 'Midfielder', age: 30),
  _TableData1(4, name: 'Romario', position: 'Forward', age: 30),
  _TableData1(5, name: 'Ronaldo', position: 'Forward', age: 30),
  _TableData1(6, name: 'Coutinho', position: 'Forward', age: 30),
  _TableData1(7, name: 'Neymar', position: 'Forward', age: 30),
  _TableData1(8, name: 'Saviola', position: 'Forward', age: 30),
  _TableData1(9, name: 'Cristiano Ronaldo', position: 'Forward', age: 30),
];

List<_TableData1> tableItems2 = [
  _TableData1(1, name: 'Klopp', position: 'Midfielder', age: 30),
  _TableData1(2, name: 'Ancelotti', position: 'Forward', age: 30),
  _TableData1(3, name: 'Rivaldo', position: 'Midfielder', age: 30),
  _TableData1(4, name: 'Romario', position: 'Forward', age: 30),
  _TableData1(5, name: 'Ronaldo', position: 'Forward', age: 30),
  _TableData1(6, name: 'Coutinho', position: 'Forward', age: 30),
  _TableData1(7, name: 'Neymar', position: 'Forward', age: 30),
  _TableData1(8, name: 'Saviola', position: 'Forward', age: 30),
  _TableData1(9, name: 'Cristiano Ronaldo', position: 'Forward', age: 30),
];

@Component(
  selector: 'tables',
  templateUrl: 'tables.html',
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
    WTableComponent,
    WDialogComponent,
    WInputComponent,
    WSpinnerComponent,
    WActionTableComponent
  ],
)
class TablesComponent {
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
  _TableData1 formData;

  WTableAdapter tblAdapter1 = WTableAdapter(
      pageSize: 3,
      totalSize: () async {
        await Future.delayed(Duration(milliseconds: 100));
        return tableItems1.length;
      },
      fetchItems: (start, end) async {
        await Future.delayed(Duration(milliseconds: 500));
        return tableItems1
            .getRange(start.clamp(0, tableItems1.length),
                end.clamp(0, tableItems1.length))
            .toList();
      });

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

  WTableFormAdapter<_TableData1> formAdapter =
      WTableFormAdapter<_TableData1>(onSubmitForm: (f, isNew) async {
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
      return _TableData1.fromTableItem(itm);
    }
    return _TableData1(tableItems2.length + 1);
  });
}
