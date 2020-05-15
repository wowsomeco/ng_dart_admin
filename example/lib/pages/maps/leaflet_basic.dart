import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

class _TileLayer {
  final String label;
  final String url;
  final TileLayerOptions options;
  final List<GeoJSONData> geojson;

  _TileLayer(this.label, this.url, this.options, {this.geojson});
}

@Component(
  selector: 'leaflet-basic',
  templateUrl: 'leaflet_basic.html',
  directives: [coreDirectives, LeafletDirective, WSelectComponent],
)
class LeafletBasicComponent {
  MapOptions mapOptions = MapOptions(
      zoom: 4,
      center: LeafletLatLng(lat: 0, lng: 115.9213),
      maxZoom: 15,
      minZoom: 10);

  static List<_TileLayer> layers = [
    _TileLayer(
        'OpenStreetMap',
        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        TileLayerOptions(
            attribution:
                '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'),
        geojson: [
          GeoJSONData(
              type: 'Feature',
              properties: {'party': 'Republican'},
              geometry: GeoJSONGeometry(type: 'Polygon', coordinates: [
                [
                  [-104.05, 48.99],
                  [-97.22, 48.98],
                  [-96.58, 45.94],
                  [-104.03, 45.94],
                  [-104.05, 48.99]
                ]
              ])),
          GeoJSONData(
              type: 'Feature',
              properties: {'party': 'Democrat'},
              geometry: GeoJSONGeometry(type: 'Polygon', coordinates: [
                [
                  [-109.05, 41.00],
                  [-102.06, 40.99],
                  [-102.03, 36.99],
                  [-109.04, 36.99],
                  [-109.05, 41.00]
                ]
              ]))
        ]),
    _TileLayer(
        'CartoDB',
        'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}{r}.png',
        TileLayerOptions(
            attribution:
                '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> &copy; <a href="http://cartodb.com/attributions">CartoDB</a>')),
    _TileLayer(
        'OpenTopoMap',
        'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
        TileLayerOptions(
            attribution:
                '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'),
        geojson: [
          GeoJSONData(
              type: 'Feature',
              properties: {
                'name': 'Coors Field',
                'amenity': 'Baseball Stadium',
                'popupContent': 'This is where the Rockies play!'
              },
              geometry: GeoJSONGeometry(
                  type: 'Point', coordinates: [-104.99404, 39.75621]))
        ]),
    _TileLayer(
        'OpenStreetMap.DE',
        'https://{s}.tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png',
        TileLayerOptions(
            attribution:
                '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'),
        geojson: [
          GeoJSONData(
              type: 'Feature',
              properties: {'party': 'Democrat'},
              geometry: GeoJSONGeometry(type: 'Polygon', coordinates: [
                [
                  [-109.05, 41.00],
                  [-102.06, 40.99],
                  [-102.03, 36.99],
                  [-109.04, 36.99],
                  [-109.05, 41.00]
                ]
              ]))
        ])
  ];

  List<WSelectOption<_TileLayer>> options =
      layers.map((x) => WSelectOption<_TileLayer>(x.label, x)).toList();

  _TileLayer selected = layers[0];
}
