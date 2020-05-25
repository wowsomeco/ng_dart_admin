import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';
import 'package:ng_admin_demo/components/darthtml_snippet/darthtml_snippet.dart';

@Component(
  selector: 'how-to-use',
  templateUrl: 'how_to_use.html',
  directives: [coreDirectives, ngAdminDirectives, DartHtmlSnippetComponent],
)
class HowToUseComponent {
  @Input('title')
  String title;

  @Input('path')
  String path;

  @Input('contentPadding')
  String contentPadding = 'pa1 pa4-ns';
}
