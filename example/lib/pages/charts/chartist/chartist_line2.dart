import 'package:angular/angular.dart';
import 'package:ng_admin/components/charts/index.dart';

@Component(
    selector: 'chartist-line2',
    templateUrl: 'chartist_line2.html',
    directives: [coreDirectives, ChartistLineDirective])
class ChartistLine2Component {
  ChartistData lineData = ChartistData(labels: [
    'Week1',
    'Week2',
    'Week3',
    'Week4',
    'Week5',
    'Week6'
  ], series: [
    [5, 4, 3, 7, 5, 10],
    [3, 2, 9, 5, 4, 6],
    [2, 1, -3, -4, -2, 0]
  ]);

  ChartistLineOptions lineOptions = ChartistLineOptions(
    showPoint: false,
    lineSmooth: false,
    axisX: AxisOptions(showGrid: false, showLabel: false),
    axisY: AxisOptions(offset: 60),
  );
}
