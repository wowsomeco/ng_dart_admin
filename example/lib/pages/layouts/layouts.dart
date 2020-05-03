import 'package:angular/angular.dart';
import 'package:ng_admin_demo/components/how_to_use/how_to_use.dart';
import 'package:ng_admin_demo/pages/layouts/layout1.dart';

@Component(
    selector: 'layouts',
    templateUrl: 'layouts.html',
    directives: [coreDirectives, Layout1Component, HowToUseComponent])
class LayoutsComponent {}
