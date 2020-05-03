import 'package:angular/angular.dart';
import 'package:ng_admin/components/charts/index.dart';

@Component(
    selector: 'chartist-bar1',
    templateUrl: 'chartist_bar1.html',
    directives: [coreDirectives, ChartistBarDirective])
class ChartistBar1Component {
  ChartistData barData = ChartistData(labels: [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ], series: [
    [5, 4, 3, 7, 5, 10, 3],
    [3, 2, 9, 5, 4, 6, 4]
  ]);

  ChartistBarOptions barOptions = ChartistBarOptions(seriesBarDistance: 10);
}
