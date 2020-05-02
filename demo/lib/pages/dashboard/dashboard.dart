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
  String readme;
  String changelog;

  @override
  void ngOnInit() async {
    String baseUrl =
        'https://raw.githubusercontent.com/wowsomeco/ng_dart_admin/master';
    readme = await HttpRequest.getString('$baseUrl/README.md');
    changelog = await HttpRequest.getString('$baseUrl/CHANGELOG.md');
  }
}
