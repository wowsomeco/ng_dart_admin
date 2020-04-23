import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Component(
  selector: 'w-dialog',
  templateUrl: 'dialog.html',
  directives: [coreDirectives],
)
class DialogComponent implements OnInit {
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
