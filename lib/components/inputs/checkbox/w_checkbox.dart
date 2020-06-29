import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(
  selector: 'w-checkbox',
  styleUrls: ['w-checkbox.css'],
  templateUrl: 'w_checkbox.html',
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
  ],
)
class WCheckboxComponent {
  @Input()
  bool value;

  final _valueChange = StreamController<bool>();
  @Output()
  Stream<bool> get valueChange => _valueChange.stream;
  void setValue(bool v) => _valueChange.add(v);
}
