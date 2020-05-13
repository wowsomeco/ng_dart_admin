import 'package:angular/angular.dart';
import 'package:ng_admin_demo/components/how_to_use/how_to_use.dart';
import 'chartist_bar1.dart';
import 'chartist_line1.dart';
import 'chartist_line2.dart';
import 'chartist_pie1.dart';

@Component(selector: 'chartists', templateUrl: 'chartists.html', directives: [
  coreDirectives,
  ChartistBar1Component,
  ChartistLine1Component,
  ChartistLine2Component,
  ChartistPie1Component,
  HowToUseComponent
])
class ChartistsComponent {
  String get cardClass => 'ba br1 b--lightest-blue pa2 ma2';
}
