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
  external GeoJsonInterface geoJSON(List<GeoJSONData> data);
}

@JS()
class LeafletMapInterface {
  external LeafletMapInterface setView(LeafletLatLng center, num zoom);
  external LeafletMapInterface invalidateSize();
  external void removeLayer(TileLayerInterface layer);
  external void fitBounds(List<LeafletLatLng> bounds, FitBoundsOptions options);
}

@anonymous
@JS()
class BaseLayer {
  external void addTo(LeafletMapInterface map);
  external void remove();
}

@JS()
class TileLayerInterface extends BaseLayer {}

@JS()
class GeoJsonInterface extends BaseLayer {
  external List<LeafletLatLng> getBounds();
}

@anonymous
@JS()
class MapOptions {
  external num get zoom;
  external num get minZoom;
  external num get maxZoom;
  external LeafletLatLng get center;

  external factory MapOptions(
      {num zoom, num minZoom, num maxZoom, LeafletLatLng center});
}

@anonymous
@JS()
class GeoJSONData {
  external String get type;
  external GeoJSONGeometry get geometry;
  external Map<String, String> get properties;

  external factory GeoJSONData(
      {String type, GeoJSONGeometry geometry, Map<String, String> properties});
}

@anonymous
@JS()
class GeoJSONGeometry {
  external String get type;
  external dynamic get coordinates;

  external factory GeoJSONGeometry({String type, dynamic coordinates});
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
class FitBoundsOptions {
  external num get maxZoom;

  external factory FitBoundsOptions({num maxZoom});
}

@anonymous
@JS()
class TileLayerOptions {
  external String get attribution;
  external num get maxZoom;
  external String get id;

  external factory TileLayerOptions(
      {String attribution, num maxZoom, String id});
}

@Directive(selector: '[leaflet]')
class LeafletDirective implements AfterChanges {
  final Element _el;
  LeafletMapInterface _map;

  @Input('LMapOptions')
  MapOptions mapOptions;

  @Input('LTileLayerUrl')
  String tileLayerUrl;

  @Input('LTileLayerOptions')
  TileLayerOptions tileLayerOptions;

  @Input('LGeoJSON')
  List<GeoJSONData> geoJson;

  final List<BaseLayer> _layers = [];

  /// contructor
  LeafletDirective(this._el);

  @override
  void ngAfterChanges() async {
    /// Clear prev layers, if any
    _clearLayers();

    /// generate map only if not exists yet
    _map ??= L.map(_el).setView(mapOptions.center, mapOptions.zoom);

    /// generate tile layer, add to _layers array
    TileLayerInterface tileLayer = L.tileLayer(tileLayerUrl, tileLayerOptions)
      ..addTo(_map);
    _layers.add(tileLayer);

    /// add polygons, lines, if any
    /// add it to _layers array too.
    GeoJsonInterface geoLayer;
    if (geoJson != null && geoJson.isNotEmpty) {
      geoLayer = L.geoJSON(geoJson)..addTo(_map);
      _layers.add(geoLayer);
    }

    /// need to delay a bit before invalidating the size
    await Future.delayed(Duration(microseconds: 10));

    _map.invalidateSize();
    if (geoJson != null && geoJson.isNotEmpty) {
      _map.fitBounds(
          geoLayer.getBounds(), FitBoundsOptions(maxZoom: mapOptions.maxZoom));
    }
  }

  void _clearLayers() => _layers.forEach((l) => l.remove());
}
