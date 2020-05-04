import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(
  selector: 'calendar-basic',
  templateUrl: 'calendar_basic.html',
  directives: [coreDirectives, ngAdminDirectives, WCalendarComponent],
)
class CalendarBasicComponent {
  DateTime fromDate = DateTime.now().subtract(Duration(days: 60));
  DateTime toDate = DateTime.now().add(Duration(days: 60));

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

  Map<String, bool> cellClass(bool first, bool last) =>
      {'justify-end': first, 'justify-start': last};

  String monthName(int val) => months[val + 1];
}
