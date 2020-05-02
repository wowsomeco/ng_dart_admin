import 'package:angular/angular.dart';
import 'package:ng_admin/components/charts/index.dart';

@Component(
    selector: 'chartist-pie1',
    templateUrl: 'chartist_pie1.html',
    directives: [coreDirectives, ChartistPieDirective])
class ChartistPie1Component {
  ChartistPieData pieData = ChartistPieData(series: [5, 3, 4]);

  ChartistPieOptions pieOptions = ChartistPieOptions(donut: true);
}
