import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(
  selector: 'calendar-monthly',
  templateUrl: 'calendar_monthly.html',
  directives: [coreDirectives, ngAdminDirectives, WCalendarComponent],
)
class CalendarMonthlyComponent {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  Map<String, bool> cellClass(bool first, bool last) =>
      {'justify-end': first, 'justify-start': last};

  Duration oneMonthDuration = Duration(days: 30);

  void nextMonth() => fromDate = toDate = fromDate.add(oneMonthDuration);

  void prevMonth() => fromDate = toDate = fromDate.subtract(oneMonthDuration);
}
