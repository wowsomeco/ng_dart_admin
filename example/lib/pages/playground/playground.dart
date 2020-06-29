import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';
import 'package:ng_admin_demo/components/how_to_use/how_to_use.dart';
import 'package:ng_admin_demo/pages/playground/login.dart';
import 'social_card.dart';
import 'report_card.dart';
import 'icon_picker.dart';
import 'common_card.dart';

class _CommonCardItem {
  final String name;
  final String date;
  final String description;

  _CommonCardItem(this.name, this.date, this.description);
}

@Component(selector: 'playground', templateUrl: 'playground.html', directives: [
  coreDirectives,
  formDirectives,
  ngAdminDirectives,
  HowToUseComponent,
  SocialCardComponent,
  ReportCardComponent,
  LoginComponent,
  IconPickerComponent,
  CommonCardComponent,
])
class PlaygroundComponent {
  String selectedIcon = 'settings';

  List<_CommonCardItem> commonCards = [
    _CommonCardItem('Kristy', '2013', 'an art director living in New York.'),
    _CommonCardItem('Molly', '2012', 'a lead artist living in San Fransisco.'),
    _CommonCardItem('Brian', '2011', 'a lead programmer living in Maine.')
  ];
}
