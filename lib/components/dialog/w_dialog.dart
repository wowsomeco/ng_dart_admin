import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

/// Component for showing the black-ish overlay with any content you feel like providing over it.
///
/// the black overlay listens to the click event where it hides the Dialog on click.
/// You need to call event.stopPropagation() on click event listener on any of the contents so that it won't hide the dialog when the content gets clicked.
@Component(
  selector: 'w-dialog',
  templateUrl: 'w_dialog.html',
  directives: [coreDirectives],
)
class WDialogComponent implements OnInit {
  /// The model.
  @Input('show')
  bool show = false;

  final _showChanged = StreamController<bool>();
  @Output()
  Stream<bool> get showChange => _showChanged.stream;

  void setShow(bool flag) => _showChanged.add(flag);

  @override
  void ngOnInit() {
    document.onKeyDown
        .where((ev) => ev.keyCode == KeyCode.ESC)
        .listen((ev) => setShow(false));
  }
}
