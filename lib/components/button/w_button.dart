import 'dart:async';

import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(
    styleUrls: ['w-button.css'],
    selector: 'w-button',
    templateUrl: 'w_button.html',
    directives: [coreDirectives, ngAdminDirectives, WSpinnerComponent])
class WButtonComponent {
  @Input('outerClass')
  dynamic outerClass;

  @Input('btnType')
  String type = 'button';

  @Input('bgColor')
  String bgColor = 'blue';

  @Input('textColor')
  String textColor = 'white';

  @Input('loading')
  bool loading = false;

  final _clicked = StreamController<Null>();
  @Output()
  Stream<Null> get click => _clicked.stream;
  void onClick() {
    if (!loading) _clicked.add(null);
  }

  List<String> get classes => ['bg-$bgColor', textColor];
}
