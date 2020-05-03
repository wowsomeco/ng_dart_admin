import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

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
  List<String> steps = ['10%', '30%', '50%', '70%', '90%'];

  num value = 25.0;
}
