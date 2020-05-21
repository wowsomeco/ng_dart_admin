import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class WSelectOption<T> {
  final String label;
  // make sure the value is unique
  final T value;
  final bool Function(String) compareTo;

  WSelectOption(this.label, this.value, this.compareTo);
}

@Component(
  selector: 'w-select',
  styleUrls: ['../input/w_input.css'],
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
class WSelectComponent implements AfterViewInit {
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

  @Input('required')
  bool isRequired = false;

  final _valueChange = StreamController<dynamic>();
  @Output()
  Stream<dynamic> get valueChange => _valueChange.stream;

  @ViewChild('optionsContainer')
  HtmlElement optionsContainer;

  @ViewChild('input')
  InputElement input;

  String _filterText;

  final WInputDecorService _decorSvc;

  bool _showingOptions = false;
  set showOptions(bool flag) {
    _showingOptions = flag;
    if (!flag) {
      _decorSvc.setFocus(false);
      _filterText = null;
    } else {
      _resetHighlighted();
    }
  }

  bool get showOptions => _showingOptions;

  List<WSelectOption> get optionsWithFilter => _filterText != null
      ? options.where((element) => element.compareTo(_filterText)).toList()
      : options;

  int get selectedItemIdx =>
      value != null ? options.indexWhere((x) => x.value == value) : null;

  String get selectedLabel => selectedItemIdx != null && selectedItemIdx >= 0
      ? options[selectedItemIdx].label
      : null;

  WSelectOption _higlightedOption;
  WSelectOption get highlighted => value != null && _higlightedOption != null
      ? optionsWithFilter.firstWhere((o) => o.value == _higlightedOption.value,
          orElse: () => null)
      : null;

  int get highlightedIdx => optionsWithFilter.indexOf(_higlightedOption);

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

    /// blur on esc
    document.onKeyDown
        .where((ev) => ev.keyCode == KeyCode.ESC)
        .listen((ev) => _onBlur());

    // bind arrow keys
    document.onKeyDown
      ..where((ev) =>
              _showingOptions &&
              (ev.keyCode == KeyCode.ENTER || ev.keyCode == KeyCode.MAC_ENTER))
          .listen((ev) => selectOption(_higlightedOption))
      ..where((ev) =>
              _showingOptions &&
              (ev.keyCode == KeyCode.UP || ev.keyCode == KeyCode.DOWN))
          .listen((KeyboardEvent ev) {
        ev.preventDefault();
        ev.keyCode == KeyCode.UP ? _prevHighlight() : _nextHighlight();
        _scrollToActive();
      });
  }

  @override
  void ngAfterViewInit() {
    if (isRequired) input.setAttribute('required', '');
    if (!searchable) input.setAttribute('readonly', '');

    input.onFocus.listen((ev) => _decorSvc.setFocus(true));
    input.onBlur.listen((ev) => _onBlur());
  }

  void selectOption(WSelectOption o) {
    _valueChange.add(o.value);
    _onBlur();
  }

  void onInputChange(String v) => _filterText = v.trim();

  Map<String, bool> getOptionItemClasses(WSelectOption o) => {
        'blue': o.value == value,
        'bg-light-gray dark-blue': o.value == _higlightedOption?.value
      };

  void _scrollToActive() {
    // get the width of the first child of the option container
    // or 50 px if no children can be found.
    int y = optionsContainer.children.isNotEmpty
        ? optionsContainer.children[0].getBoundingClientRect().height.toInt()
        : 50;
    optionsContainer.scrollTop = (highlightedIdx * y);
  }

  void _onBlur() {
    input.blur();
    showOptions = false;
    input.value = selectedLabel;
  }

  void _resetHighlighted() {
    if (value != null) {
      _higlightedOption = optionsWithFilter
          .firstWhere((el) => el.value == value, orElse: () => null);
    } else if (optionsWithFilter.isNotEmpty) {
      _higlightedOption = optionsWithFilter[0];
    }
  }

  void _nextHighlight() {
    if (optionsWithFilter.isEmpty) return;
    int cur = _clamp(highlightedIdx + 1, 0, optionsWithFilter.length);
    _higlightedOption = optionsWithFilter[cur];
  }

  void _prevHighlight() {
    if (optionsWithFilter.isEmpty) return;
    int cur = _clamp(highlightedIdx - 1, 0, optionsWithFilter.length);
    _higlightedOption = optionsWithFilter[cur];
  }

  int _clamp(int idx, int min, int max) =>
      idx < min ? max - 1 : idx > max - 1 ? min : idx;
}
