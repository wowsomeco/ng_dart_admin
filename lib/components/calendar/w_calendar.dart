import 'package:angular/angular.dart';

class _CalWeek {
  List<DateTime> days = [];
}

class _CalMonth {
  int year;
  int value;
  List<_CalWeek> weeks = [_CalWeek()];

  _CalMonth(this.value, this.year);

  _CalWeek get curWeek => weeks.last;
  set curWeek(_CalWeek m) => weeks.add(m);
}

class _CalYear {
  List<_CalMonth> months = [];

  _CalMonth get curMonth => months.last;
  set curMonth(_CalMonth m) => months.add(m);
}

@Component(
  selector: 'w-calendar',
  templateUrl: 'w_calendar.html',
  directives: [coreDirectives],
)
class WCalendarComponent implements AfterChanges {
  @Input('firstDate')
  DateTime firstDate = DateTime.now();

  @Input('endDate')
  DateTime endDate = DateTime.now();

  @ContentChild('month')
  TemplateRef month;

  _CalYear currentYear;

  @override
  void ngAfterChanges() {
    currentYear = _CalYear();
    currentYear.curMonth = _CalMonth(firstDate.month, firstDate.year);

    Duration oneDayDuration = Duration(days: 1);
    DateTime cur = DateTime(firstDate.year, firstDate.month);

    /// last date is the last date of the [endDate]'s month
    DateTime last =
        DateTime(endDate.year, endDate.month + 1, 1).subtract(oneDayDuration);

    /// loop until cur exceeds last
    while (cur.compareTo(last) < 1) {
      /// set new month if the cur iterator is not the same as curMonth in the currentYear
      if (currentYear.curMonth.value != cur.month) {
        currentYear.curMonth = _CalMonth(cur.month, cur.year);
      }

      /// add days to the curWeek
      currentYear.curMonth.curWeek.days.add(cur);

      /// add new week to curMonth.curWeek array after sunday
      if (cur.weekday == DateTime.sunday) {
        currentYear.curMonth.curWeek = _CalWeek();
      }

      cur = cur.add(oneDayDuration);
    }
  }
}
