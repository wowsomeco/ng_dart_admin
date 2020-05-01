@JS()
library leaflet_interop;

import 'dart:html';
import 'package:angular/core.dart';
import 'package:js/js.dart';

@JS()
external LeafletInterface get L;

@JS()
class LeafletInterface {
  external LeafletMapInterface map(Element el);
  external TileLayerInterface tileLayer(String url, TileLayerOptions options);
}

@JS()
class LeafletMapInterface {
  external LeafletMapInterface setView(LeafletLatLng center, num zoom);
  external LeafletMapInterface invalidateSize();
}

@JS()
class TileLayerInterface {
  external void addTo(LeafletMapInterface map);
}

@anonymous
@JS()
class LeafletOptions {
  external num get zoom;
  external LeafletLatLng get center;

  external factory LeafletOptions({num zoom, LeafletLatLng center});
}

@anonymous
@JS()
class LeafletLatLng {
  external num get lat;
  external num get lng;

  external factory LeafletLatLng({num lat, num lng});
}

@anonymous
@JS()
class TileLayerOptions {
  external String get attribution;

  external factory TileLayerOptions({String attribution});
}

@Directive(selector: '[leaflet]')
class LeafletDirective implements OnInit, AfterChanges {
  final Element _el;
  LeafletMapInterface _map;

  @Input('leafletOptions')
  LeafletOptions options;

  LeafletDirective(this._el);

  @override
  void ngOnInit() async {
    _map = L.map(_el).setView(options.center, options.zoom);
    L
        .tileLayer(
            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            TileLayerOptions(
                attribution:
                    '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'))
        .addTo(_map);
    await Future.delayed(Duration(microseconds: 100));
    _map.invalidateSize();
  }

  @override
  void ngAfterChanges() {}
}
