@JS()
library showdown_interop;

import 'dart:html';
import 'package:js/js.dart';
import 'package:angular/angular.dart';

@JS('showdown.Converter')
class Converter {
  external String makeHtml(String md);
}

@Directive(selector: '[showdownjs]')
class ShowdownDirective implements AfterViewInit {
  @Input('mdSource')
  String md;

  final Element _el;

  ShowdownDirective(this._el);

  @override
  void ngAfterViewInit() {
    String html = Converter().makeHtml(md);
    _el.innerHtml = html;
  }
}
