import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

class StaticTableProvider extends TableDataProvider {
  final List<TableItem> _items = [
    TableItem({'Name': 'John Doe', 'Position': 'Accountant', 'Age': 20}),
    TableItem(
        {'Name': 'Pablo Aimar', 'Position': 'Software Engineer', 'Age': 71}),
    TableItem({'Name': 'Coutinho', 'Position': 'Midfielder', 'Age': 21}),
    TableItem({'Name': 'Pug', 'Position': 'Anjing', 'Age': 21}),
    TableItem({'Name': 'Pitbull', 'Position': 'Anjing', 'Age': 21}),
    TableItem({'Name': 'Anjing kukuk', 'Position': 'Anjing', 'Age': 21}),
    TableItem({'Name': 'Mantis', 'Position': 'Anjing', 'Age': 21}),
    TableItem({'Name': 'Herder', 'Position': 'Anjing', 'Age': 21}),
    TableItem({'Name': 'Doberman', 'Position': 'Anjing', 'Age': 21}),
  ];

  @override
  int get pageSize => 3;

  @override
  Future<List<TableItem>> tableItems(int start, int end) async {
    await Future.delayed(Duration(milliseconds: 300));
    return _items
        .getRange(start.clamp(0, _items.length), end.clamp(0, _items.length))
        .toList();
  }

  @override
  int get collectionSize => _items.length;
}

@Component(
    selector: 'dashboard',
    templateUrl: 'dashboard.html',
    directives: [coreDirectives, TableComponent, DialogComponent],
    providers: [])
class DashboardComponent {
  bool showModal = false;

  StaticTableProvider staticTableProvider = StaticTableProvider();
}
