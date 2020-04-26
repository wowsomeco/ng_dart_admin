import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class SelectOption<T> {
  final String label;
  final T value;

  SelectOption(this.label, this.value);
}

@Component(
  selector: 'w-select',
  templateUrl: 'w_select.html',
  providers: [ClassProvider(WInputDecorService)],
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
    WInputDecoratorComponent
  ],
)
class WSelectComponent {
  @Input('options')
  List<SelectOption> options = [];

  @Input('selected')
  SelectOption selected;

  final _selected = StreamController<SelectOption>();
  @Output()
  Stream<SelectOption> get selectedChange => _selected.stream;

  bool showOption = false;

  final WInputDecorService _service;

  WSelectComponent(this._service) {
    _service.focus.listen((ev) => showOption = ev);
    _service.onClear.listen((ev) => _selected.add(null));
  }

  int get selectedItemIdx {
    return selected != null
        ? options.indexWhere((x) => x.label == selected.label)
        : null;
  }

  void onSelectItem(int idx) {
    _selected.add(options[idx]);
    showOption = false;
    _service.setFocus(showOption);
  }
}
