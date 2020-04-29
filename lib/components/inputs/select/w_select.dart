import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class WSelectOption<T> {
  final String label;
  final T value;

  WSelectOption(this.label, this.value);
}

class WSelectAdapter<T> {
  final Future<List<WSelectOption<T>>> Function() fetchOptions;

  WSelectAdapter({this.fetchOptions});
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
class WSelectComponent implements OnInit {
  @Input('adapter')
  WSelectAdapter adapter;

  @Input('selected')
  dynamic selected;

  List<WSelectOption> options = [];
  bool showOption = false;

  final _selected = StreamController<WSelectOption>();
  @Output()
  Stream<WSelectOption> get selectedChange => _selected.stream;

  final WInputDecorService _service;

  WSelectComponent(this._service) {
    _service.focus.listen((ev) => showOption = ev);
    _service.onClear.listen((ev) => _selected.add(null));
  }

  int get selectedItemIdx {
    return selected != null
        ? options.indexWhere((x) => x.value == selected)
        : null;
  }

  String get selectedLabel {
    return selectedItemIdx >= 0 ? options[selectedItemIdx].label : null;
  }

  void onSelectItem(int idx) {
    // still wrong
    _selected.add(options[idx]);
    showOption = false;
    _service.setFocus(showOption);
  }

  @override
  void ngOnInit() async {
    _service.setLoading(true);
    options = await adapter.fetchOptions();
    _service.setLoading(false);
  }
}
