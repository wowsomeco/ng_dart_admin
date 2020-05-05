import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';
import 'package:ng_admin_demo/components/how_to_use/how_to_use.dart';
import 'tachyon_cards.dart';

@Component(selector: 'playground', templateUrl: 'playground.html', directives: [
  coreDirectives,
  formDirectives,
  ngAdminDirectives,
  HowToUseComponent,
  TachyonCardsComponent
])
class PlaygroundComponent {}
