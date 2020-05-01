import 'dart:async';
import 'dart:html';
import 'package:angular/core.dart';

@Directive(selector: '[wClipboard]')
class WClipboardDirective implements AfterViewInit {
  /// clipboard elem id
  @Input('clipboardId')
  String clipboardId;

  /// delay in ms until [copying] changes back to false again.
  @Input('copyDuration')
  int duration = 500;

  /// when [_el] is clicked, [copying] will output true for [duration] ms
  /// then will send false once the delay done
  final _copying = StreamController<bool>();
  @Output()
  Stream<bool> get copying => _copying.stream;

  final Element _el;
  Element _target;

  WClipboardDirective(this._el);

  @override
  void ngAfterViewInit() {
    _target = document.getElementById(clipboardId);
    assert(_target != null,
        'cant find clipboard element with id clipboard=$clipboardId');

    /// copy to clipboard on click
    _el.onClick.listen((ev) async {
      Range range = document.createRange();
      range.selectNode(_target);
      window.getSelection().removeAllRanges();
      window.getSelection().addRange(range);
      document.execCommand('copy');
      window.getSelection().removeAllRanges();

      _copying.add(true);
      await Future.delayed(Duration(milliseconds: duration))
          .then((ev) => _copying.add(false));
    });
  }
}
