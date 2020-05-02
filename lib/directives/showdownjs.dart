@JS()
library showdown_interop;

import 'dart:html';
import 'package:js/js.dart';
import 'package:angular/angular.dart';

@JS('showdown.Converter')
class Converter {
  external String makeHtml(String md);
  external factory Converter();
}

@Directive(selector: '[showdownjs]')
class ShowdownDirective implements AfterViewInit {
  @Input('mdSource')
  String md;

  final Element _el;

  ShowdownDirective(this._el);

  @override
  void ngAfterViewInit() {
    var converter = Converter();
    String html = converter.makeHtml(md);
    _el.innerHtml = html;
  }
}
