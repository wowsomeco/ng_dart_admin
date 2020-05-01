@JS()
library chartist_interop;

import 'dart:html';
import 'package:angular/core.dart';
import 'package:js/js.dart';

@JS()
external ChartistInterface get Chartist;

@JS()
class ChartistInterface {
  external void Line(
      Element el, ChartistData data, ChartistLineOptions options);
  external void Bar(Element el, ChartistData data, ChartistBarOptions options);
  external void Pie(
      Element el, ChartistPieData data, ChartistPieOptions options);
}

@anonymous
@JS()
class ChartistData {
  external List<dynamic> get labels;
  external List<List<dynamic>> get series;

  external factory ChartistData(
      {List<dynamic> labels, List<List<dynamic>> series});
}

@anonymous
@JS()
class ChartistLineOptions {
  external bool get fullWidth;
  external num get low;
  external num get high;

  external factory ChartistLineOptions({bool fullWidth, num low, num high});
}

@anonymous
@JS()
class ChartistBarOptions {
  external bool get distributedSeries;
  external int get seriesBarDistance;
  external bool get horizontalBars;
  external bool get reverseData;

  external factory ChartistBarOptions(
      {bool distributedSeries,
      int seriesBarDistance,
      bool horizontalBars,
      bool reverseData});
}

@anonymous
@JS()
class ChartistPieData {
  external List<dynamic> get labels;
  external List<int> get series;

  external factory ChartistPieData({List<dynamic> labels, List<int> series});
}

@anonymous
@JS()
class ChartistPieOptions {
  external bool get donut;

  external factory ChartistPieOptions({bool donut});
}

@Directive(selector: '[chartist-line]')
class ChartistLineDirective implements AfterChanges {
  final Element _el;

  @Input('clData')
  ChartistData data;

  @Input('clOptions')
  ChartistLineOptions options;

  ChartistLineDirective(this._el);

  @override
  void ngAfterChanges() => Chartist.Line(_el, data, options);
}

@Directive(selector: '[chartist-bar]')
class ChartistBarDirective implements AfterChanges {
  final Element _el;

  @Input('clData')
  ChartistData data;

  @Input('clOptions')
  ChartistBarOptions options;

  ChartistBarDirective(this._el);

  @override
  void ngAfterChanges() => Chartist.Bar(_el, data, options);
}

@Directive(selector: '[chartist-pie]')
class ChartistPieDirective implements AfterChanges {
  final Element _el;

  @Input('clData')
  ChartistPieData data;

  @Input('clOptions')
  ChartistPieOptions options;

  ChartistPieDirective(this._el);

  @override
  void ngAfterChanges() => Chartist.Pie(_el, data, options);
}
