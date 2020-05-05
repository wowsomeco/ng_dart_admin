import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';
import '_calendar_common.dart';

@Component(
  selector: 'calendar-basic',
  templateUrl: 'calendar_basic.html',
  directives: [coreDirectives, ngAdminDirectives, WCalendarComponent],
)
class CalendarBasicComponent {
  DateTime fromDate = DateTime.now().subtract(Duration(days: 30));
  DateTime toDate = DateTime.now().add(Duration(days: 30));
  CalendarCommon common = CalendarCommon();

  Map<String, bool> cellClass(bool first, bool last) =>
      {'justify-end': first, 'justify-start': last};
}
