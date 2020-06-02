import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';
import 'package:ng_admin_demo/components/how_to_use/how_to_use.dart';
import 'package:ng_admin_demo/pages/playground/login.dart';
import 'social_card.dart';
import 'report_card.dart';

@Component(selector: 'playground', templateUrl: 'playground.html', directives: [
  coreDirectives,
  formDirectives,
  ngAdminDirectives,
  HowToUseComponent,
  SocialCardComponent,
  ReportCardComponent,
  LoginComponent
])
class PlaygroundComponent {}
