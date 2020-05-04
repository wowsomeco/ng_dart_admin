import 'package:angular/angular.dart';
import 'package:ng_admin_demo/components/how_to_use/how_to_use.dart';
import 'calendar_basic.dart';

@Component(
    selector: 'calendars',
    templateUrl: 'calendars.html',
    directives: [coreDirectives, HowToUseComponent, CalendarBasicComponent])
class CalendarsComponent {}
