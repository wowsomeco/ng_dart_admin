import 'package:angular/angular.dart';
import 'package:ng_admin_demo/components/how_to_use/how_to_use.dart';
import 'frappe_mixed_axis.dart';

@Component(
    selector: 'frappes',
    templateUrl: 'frappes.html',
    directives: [coreDirectives, FrappeMixedAxisComponent, HowToUseComponent])
class FrappesComponent {}
