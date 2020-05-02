import 'package:angular/angular.dart';
import 'chartist_bar1.dart';
import 'chartist_line1.dart';
import 'chartist_pie1.dart';

@Component(selector: 'chartists', templateUrl: 'chartists.html', directives: [
  coreDirectives,
  ChartistBar1Component,
  ChartistLine1Component,
  ChartistPie1Component
])
class ChartistsComponent {
  String get cardClass => 'ba br1 b--lightest-blue pa2 ma2';
}
