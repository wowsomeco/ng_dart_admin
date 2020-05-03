import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

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

@Component(
  selector: 'table1',
  templateUrl: 'table1.html',
  directives: [coreDirectives, ngAdminDirectives, WTableComponent],
)
class Table1Component {
  WTableAdapter adapter = WTableAdapter(
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
            .toList();
      });
}
