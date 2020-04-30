import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class _SliderData {
  final String name;
  final String icon;

  _SliderData(this.name, this.icon);
}

@Component(
  selector: 'slider1',
  templateUrl: 'slider1.html',
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
    WSliderComponent
  ],
)
class Slider1Component {
  List<_SliderData> steps = [
    _SliderData('title 1', 'person'),
    _SliderData('title 2', 'dashboard'),
  ];

  num value = 75;
}
