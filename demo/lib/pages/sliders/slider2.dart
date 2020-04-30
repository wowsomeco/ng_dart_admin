import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class _SliderData {
  final int number;

  _SliderData(this.number);
}

@Component(
  selector: 'slider2',
  templateUrl: 'slider2.html',
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
    WSliderComponent
  ],
)
class Slider2Component {
  List<_SliderData> steps = [
    _SliderData(1),
    _SliderData(2),
  ];

  num value = 25.0;
}
