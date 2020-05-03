import 'dart:html';

import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(
    selector: 'nested-tab',
    templateUrl: 'nested_tab.html',
    directives: [coreDirectives, ngAdminDirectives])
class NestedTabComponent implements OnInit {
  String sampleCode;

  @override
  void ngOnInit() async {
    sampleCode = await HttpRequest.getString(
        'https://raw.githubusercontent.com/wowsomeco/ng_dart_admin/master/demo/lib/pages/sliders/slider1.dart');
  }
}
