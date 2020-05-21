import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class WSelectOption<T> {
  final String label;
  final T value;
  final bool Function(String) compareTo;

  WSelectOption(this.label, this.value, this.compareTo);
}

@Component(
  selector: 'w-select',
  templateUrl: 'w_select.html',
  providers: [ClassProvider(WInputDecorService)],
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
    WInputDecoratorComponent,
    WInputComponent
  ],
)
class WSelectComponent {
  @Input('options')
  List<WSelectOption> options = [];

  @Input('value')
  dynamic value;

  @Input('clearable')
  bool clearable;

  @Input('searchable')
  bool searchable = true;

  @Input('loading')
  set loading(bool flag) => _decorSvc.setLoading(flag);

  final _valueChange = StreamController<dynamic>();
  @Output()
  Stream<dynamic> get valueChange => _valueChange.stream;

  @ViewChild('optionsContainer')
  HtmlElement optionsContainer;

  String filterText;

  List<WSelectOption> get optionsWithFilter => filterText != null
      ? options.where((element) => element.compareTo(filterText)).toList()
      : options;

  final WInputDecorService _decorSvc;

  bool _showingOptions = false;
  set showOptions(bool flag) {
    _showingOptions = flag;
    if (!flag) {
      _decorSvc.setFocus(false);
      filterText = null;
    }
  }

  bool get showOptions => _showingOptions;

  int get selectedItemIdx =>
      value != null ? options.indexWhere((x) => x.value == value) : null;

  String get selectedLabel => selectedItemIdx != null && selectedItemIdx >= 0
      ? options[selectedItemIdx].label
      : null;

  /// the constructor
  WSelectComponent(this._decorSvc) {
    /// listen to decor svc
    /// show options on focus
    /// nullify value on clear
    _decorSvc
      ..focus.listen((ev) {
        _showingOptions = ev;
        if (ev) _scrollToActive();
      })
      ..onClear.listen((ev) => _valueChange.add(null));
  }

  void selectOption(WSelectOption o) {
    _valueChange.add(o.value);
    showOptions = false;
  }

  Map<String, bool> getOptionItemClasses(WSelectOption o) =>
      {'blue': o.value == value};

  void _scrollToActive() {
    // get the width of the first child of the option container
    // or 50 px if no children can be found.
    int y = optionsContainer.children.isNotEmpty
        ? optionsContainer.children[0].getBoundingClientRect().height.toInt()
        : 50;
    optionsContainer.scrollTop = (selectedItemIdx ?? 0 * y);
  }
}
