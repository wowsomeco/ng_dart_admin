import 'package:angular/angular.dart';
import 'package:ng_admin/components/maps/leaflet.dart';

@Component(
  selector: 'maps',
  templateUrl: 'maps.html',
  directives: [coreDirectives, LeafletDirective],
)
class MapsComponent {
  LeafletOptions leafletOptions =
      LeafletOptions(zoom: 4, center: LeafletLatLng(lat: 0, lng: 115.9213));
}
