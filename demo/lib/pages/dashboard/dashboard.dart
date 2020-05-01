import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(selector: 'dashboard', templateUrl: 'dashboard.html', directives: [
  coreDirectives,
  formDirectives,
  ngAdminDirectives,
])
class DashboardComponent implements OnInit {
  String htmlCode;

  @override
  void ngOnInit() async {
    htmlCode = await HttpRequest.getString(
        'https://raw.githubusercontent.com/wowsomeco/ng_dart_admin/master/demo/web/index.html');
  }
}
