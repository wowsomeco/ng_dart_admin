import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

class _CalEvent {
  final String name;
  final String classes;
  final String icon;

  _CalEvent(this.name, this.classes, {this.icon});
}

@Component(
  selector: 'calendar-events',
  templateUrl: 'calendar_events.html',
  directives: [coreDirectives, ngAdminDirectives, WCalendarComponent],
)
class CalendarWithEventsComponent {
  DateTime fromDate = DateTime.now().subtract(Duration(days: 60));
  DateTime toDate = DateTime.now().add(Duration(days: 60));

  Map<String, List<_CalEvent>> calEvents = {
    '2020-5-4': [_CalEvent('My Birthday', 'green', icon: 'person')],
    '2020-5-10': [
      _CalEvent('Your Birthday', 'purple'),
      _CalEvent('Event 2', 'navy')
    ],
    '2020-5-15': [_CalEvent('Corona dead', 'pink')],
  };

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

  List<_CalEvent> getEvents(DateTime date) =>
      calEvents.containsKey('${date.year}-${date.month}-${date.day}')
          ? calEvents['${date.year}-${date.month}-${date.day}']
          : [];
}
