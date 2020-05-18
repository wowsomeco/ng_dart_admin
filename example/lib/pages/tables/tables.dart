import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';
import 'package:ng_admin_demo/components/how_to_use/how_to_use.dart';
import 'table1.dart';
import 'table2.dart';
import 'table_with_filter.dart';

@Component(
  selector: 'tables',
  templateUrl: 'tables.html',
  directives: [
    coreDirectives,
    ngAdminDirectives,
    Table1Component,
    Table2Component,
    TableFilterComponent,
    HowToUseComponent
  ],
)
class TablesComponent {}
