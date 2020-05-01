import 'dart:html';

import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(
    selector: 'code-snippet',
    templateUrl: 'code_snippet.html',
    directives: [coreDirectives, ngAdminDirectives])
class CodeSnippetComponent implements OnInit {
  /// path to the github folder where the file is located at
  @Input('path')
  String path;

  /// html, dart, etc.
  @Input('lang')
  String lang;

  String sourceCode;

  final String _baseUrl =
      'https://raw.githubusercontent.com/wowsomeco/ng_dart_admin/master/demo';

  @override
  void ngOnInit() async {
    sourceCode = await HttpRequest.getString('$_baseUrl/$path');
  }
}
