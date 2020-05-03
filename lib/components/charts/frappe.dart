@JS()
library frappe_interop;

import 'dart:html';
import 'package:js/js.dart';
import 'package:angular/angular.dart';

@JS('frappe.Chart')
class FrappeChart {
  external factory FrappeChart(Element el, FrappeConfig config);
}

@anonymous
@JS()
class FrappeConfig {
  external String get title;
  external String get type;
  external int get height;
  external FrappeData get data;
  external List<String> get colors;

  external factory FrappeConfig(
      {String title,
      String type,
      int height,
      FrappeData data,
      List<String> colors});
}

@anonymous
@JS()
class FrappeData {
  external List<dynamic> get labels;
  external List<FrappeDataset> get datasets;

  external factory FrappeData(
      {List<dynamic> labels, List<FrappeDataset> datasets});
}

@anonymous
@JS()
class FrappeDataset {
  external String get name;
  external String get type;
  external List<dynamic> get values;

  external factory FrappeDataset(
      {String name, String type, List<dynamic> values});
}

@Directive(selector: '[frappeChart]')
class FrappeDirective implements OnInit {
  @Input('frappeConfig')
  FrappeConfig config;

  final Element _el;

  FrappeDirective(this._el);

  @override
  void ngOnInit() async {
    /// need to delay a bit, otherwise frappe will throw some svg NaN error
    await Future.delayed(Duration(milliseconds: 10));
    FrappeChart(_el, config);
  }
}
