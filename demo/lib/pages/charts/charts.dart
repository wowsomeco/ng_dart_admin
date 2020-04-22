import 'package:angular/angular.dart';
import 'package:ng_admin/components/charts/index.dart';

@Component(selector: 'charts', templateUrl: 'charts.html', directives: [
  coreDirectives,
  ChartistLineDirective,
  ChartistBarDirective,
  ChartistPieDirective
], providers: [])
class ChartsComponent {
  ChartistData lineData = ChartistData(series: [
    [1, 2, 3, 1, -2, 0, 1, 0],
    [-2, -1, -2, -1, -3, -1, -2, -1],
    [0, 0, 0, 1, 2, 3, 2, 1],
    [3, 2, 1, 0.5, 1, 0, -1, -3]
  ], labels: [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8
  ]);

  ChartistLineOptions lineOptions =
      ChartistLineOptions(fullWidth: true, high: 3, low: -3);

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

  ChartistPieData pieData = ChartistPieData(series: [5, 3, 4]);

  ChartistPieOptions pieOptions = ChartistPieOptions(donut: true);
}
