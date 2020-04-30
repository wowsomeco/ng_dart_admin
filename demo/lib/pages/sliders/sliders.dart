import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';
import 'slider1.dart';
import 'slider2.dart';

@Component(
  selector: 'sliders',
  templateUrl: 'sliders.html',
  directives: [
    coreDirectives,
    ngAdminDirectives,
    WSliderComponent,
    Slider1Component,
    Slider2Component
  ],
)
class SlidersComponent {
  String get cardClass =>
      'ba br1 b--lightest-blue mv2 pa3 flex flex-column h-100';
}
