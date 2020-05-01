@JS()
library highlight_interop;

import 'dart:html';
import 'package:js/js.dart';
import 'package:angular/angular.dart';

@JS()
external HljsInterface get hljs;

@JS()
class HljsInterface {
  external void highlightBlock(Element block);
  external void configure(HlConfigOptions options);
  external HighlightAutoInterface highlightAuto(String snippet);
}

@JS()
@anonymous
class HlConfigOptions {
  external factory HlConfigOptions({bool useBr});
  external set useBr(bool useBrVal);
}

@JS()
class HighlightAutoInterface {
  external String get value;
}

@Directive(selector: '[hljs]')
class HljsDirective implements AfterViewInit {
  final Element _el;

  HljsDirective(this._el);

  @override
  void ngAfterViewInit() {
    hljs.highlightBlock(_el);
  }
}
