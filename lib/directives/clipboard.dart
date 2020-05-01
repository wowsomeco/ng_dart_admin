import 'dart:html';
import 'package:angular/core.dart';

@Directive(selector: '[wClipboard]')
class WClipboardDirective implements AfterViewInit {
  /// clipboard elem id
  @Input('clipboardId')
  String clipboardId;

  final Element _el;
  Element _target;

  WClipboardDirective(this._el);

  @override
  void ngAfterViewInit() {
    _target = document.getElementById(clipboardId);
    assert(_target != null,
        'cant find clipboard element with id clipboard=$clipboardId');

    /// copy to clipboard on click
    _el.onClick.listen((ev) {
      Range range = document.createRange();
      range.selectNode(_target);
      window.getSelection().removeAllRanges();
      window.getSelection().addRange(range);
      document.execCommand('copy');
      window.getSelection().removeAllRanges();
    });
  }
}
