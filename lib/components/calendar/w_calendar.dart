import 'package:angular/angular.dart';

class _CalDay {
  final String name;
  final DateTime value;
  final bool isToday;

  _CalDay(this.name, this.value, this.isToday);
}

class _CalWeek {
  List<_CalDay> days = [];
}

class _CalMonth {
  final int year;
  final int value;
  final String name;
  List<_CalWeek> weeks = [_CalWeek()];
  List<String> days;

  _CalMonth(this.name, this.value, this.year, this.days);

  _CalWeek get curWeek => weeks.last;
  set curWeek(_CalWeek m) => weeks.add(m);
}

class _CalYear {
  List<_CalMonth> months = [];

  _CalMonth get curMonth => months.last;
  set curMonth(_CalMonth m) => months.add(m);
}

/// Component that can be used to build any form of custom calendar.
///
/// this component is quite low level whereby it only has <template> that leaves to the caller to use it whatever they like.
/// refer to https://ngadmin.wowsome.co/#/calendars for samples how to use it.
@Component(
  selector: 'w-calendar',
  templateUrl: 'w_calendar.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
  directives: [coreDirectives],
)
class WCalendarComponent implements AfterChanges {
  /// The earliest date the user is permitted to pick.
  @Input('firstDate')
  DateTime firstDate = DateTime.now();

  /// The latest date the user is permitted to pick.
  @Input('endDate')
  DateTime endDate = DateTime.now();

  /// days string prop.
  /// change them accordingly
  @Input('days')
  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  /// months string prop.
  /// change them accordingly
  @Input('months')
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @ContentChild('month')
  TemplateRef month;

  _CalYear currentYear;

  @override
  void ngAfterChanges() {
    DateTime today = DateTime.now();
    currentYear = _CalYear();
    currentYear.curMonth = _CalMonth(
        months[firstDate.month - 1], firstDate.month, firstDate.year, days);

    Duration oneDayDuration = Duration(days: 1);
    DateTime cur = DateTime(firstDate.year, firstDate.month);

    /// last date is the last date of the [endDate]'s month
    DateTime last =
        DateTime(endDate.year, endDate.month + 1, 1).subtract(oneDayDuration);

    /// loop until cur exceeds last
    while (cur.compareTo(last) < 1) {
      /// set new month if the cur iterator is not the same as curMonth in the currentYear
      if (currentYear.curMonth.value != cur.month) {
        currentYear.curMonth =
            _CalMonth(months[cur.month - 1], cur.month, cur.year, days);
      }

      /// add days to the curWeek
      currentYear.curMonth.curWeek.days
          .add(_CalDay(days[cur.weekday - 1], cur, _isSameDate(today, cur)));

      /// add new week to curMonth.curWeek array after sunday
      if (cur.weekday == DateTime.sunday && !_isLastDayOfMonth(cur)) {
        currentYear.curMonth.curWeek = _CalWeek();
      }

      cur = cur.add(oneDayDuration);
    }
  }

  bool _isSameDate(DateTime one, DateTime another) =>
      one.day == another.day &&
      one.month == another.month &&
      one.year == another.year;

  bool _isLastDayOfMonth(DateTime cur) =>
      cur.day == DateTime(cur.year, cur.month + 1, 0).day;
}
