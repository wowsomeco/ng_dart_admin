import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';
import 'package:ng_admin_demo/components/code_snippet/code_snippet.dart';

@Component(
    selector: 'darthtml-snippet',
    templateUrl: 'darthtml_snippet.html',
    directives: [coreDirectives, ngAdminDirectives, CodeSnippetComponent])
class DartHtmlSnippetComponent {
  /// path to the github folder where the file is located at
  @Input('path')
  String path;

  String get htmlPath => '$path.html';

  String get dartPath => '$path.dart';
}
