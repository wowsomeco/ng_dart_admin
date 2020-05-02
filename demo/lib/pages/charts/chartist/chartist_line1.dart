import 'package:angular/angular.dart';
import 'package:ng_admin/components/charts/index.dart';

@Component(
    selector: 'chartist-line1',
    templateUrl: 'chartist_line1.html',
    directives: [coreDirectives, ChartistLineDirective])
class ChartistLine1Component {
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
}
