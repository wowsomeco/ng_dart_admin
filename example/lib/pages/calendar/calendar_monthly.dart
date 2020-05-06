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

  /// You can simply rename the months to whatever you like.
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  /// You can simply rename the days to whatever you like.
  List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  void nextMonth() => fromDate = toDate = fromDate.add(oneMonthDuration);

  void prevMonth() => fromDate = toDate = fromDate.subtract(oneMonthDuration);
}
