import 'dart:async';

import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(
  selector: 'icon-picker',
  templateUrl: 'icon_picker.html',
  directives: [coreDirectives, ngAdminDirectives, WSelectComponent],
)
class IconPickerComponent {
  @Input('label')
  String label = 'Pick Icon';

  @Input('clearable')
  bool clearable = false;

  @Input('value')
  String value;

  final _valueChange = StreamController<String>();
  @Output()
  Stream<String> get valueChange => _valueChange.stream;

  void changeValue(String v) => _valueChange.add(v);

  List<WSelectOption<String>> options = [];

  IconPickerComponent() {
    options = [
      'dashboard',
      'settings',
      'accessibility',
      'autorenew',
      'backup',
      'check_circle'
    ]
        .map((e) => WSelectOption(e.replaceAll('_', '').toUpperCase(), e))
        .toList();
  }
}
