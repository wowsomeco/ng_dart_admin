import 'package:angular/angular.dart';
import 'package:ng_admin/components/charts/index.dart';

@Component(
    selector: 'frappe-mixed-axis',
    templateUrl: 'frappe_mixed_axis.html',
    directives: [coreDirectives, FrappeDirective])
class FrappeMixedAxisComponent {
  FrappeConfig config = FrappeConfig(
      title: 'Awesome Chart',
      type: 'axis-mixed',
      height: 250,
      colors: ['#7cd6fd', '#743ee2'],
      data: FrappeData(labels: [
        '12am-3am',
        '3am-6pm',
        '6am-9am',
        '9am-12am',
        '12pm-3pm',
        '3pm-6pm',
        '6pm-9pm',
        '9am-12am'
      ], datasets: [
        FrappeDataset(
            name: 'Some Data',
            type: 'bar',
            values: [25, 40, 30, 35, 8, 52, 17, -4]),
        FrappeDataset(
            name: 'Another Data',
            type: 'line',
            values: [25, 50, -10, 15, 18, 32, 27, 14]),
      ]));
}
