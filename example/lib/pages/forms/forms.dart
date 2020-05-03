import 'package:angular/angular.dart';
import 'form1.dart';
import 'form2.dart';

@Component(
    selector: 'forms',
    templateUrl: 'forms.html',
    directives: [Form1Component, Form2Component])
class FormsComponent {
  String get cardClass => 'ba br1 b--light-gray mv1';
}
