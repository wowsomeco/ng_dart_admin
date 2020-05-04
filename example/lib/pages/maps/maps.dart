import 'package:angular/angular.dart';
import 'package:ng_admin_demo/components/how_to_use/how_to_use.dart';
import 'leaflet_basic.dart';

@Component(
  selector: 'maps',
  templateUrl: 'maps.html',
  directives: [coreDirectives, LeafletBasicComponent, HowToUseComponent],
)
class MapsComponent {}
