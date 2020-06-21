import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class WSelectOption<T> {
  final String label;

  /// make sure the value is unique
  final T value;

  /// callback that gets called to check equality when the input gets changed.
  /// if it is not supplied, it will compare against the [label] instead.
  final bool Function(String) compareTo;

  WSelectOption(this.label, this.value, {this.compareTo});
}

/// The Input Component that can be used to show any array-like data, just like how native <select> does, with more options to customize.
///
/// It can set to be loading to show the loading indicator,
/// can also filter out the options whenever the input value changes its value, just make sure [searchable] is set to true to activate it.
@Component(
  selector: 'w-select',
  styleUrls: ['../input/w_input.css'],
  templateUrl: 'w_select.html',
  providers: [ClassProvider(WInputDecorService)],
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
    WInputDecoratorComponent
  ],
)
class WSelectComponent implements AfterViewInit {
  /// the dropdown options to be shown when the input field gets focused.
  @Input('options')
  List<WSelectOption> options = [];

  /// the model.
  ///
  /// it can be anything, just make sure the options contain this value too.
  @Input('value')
  dynamic value;

  /// when it sets to true, will show the close button icon that will nullify the value on clicked.
  @Input('clearable')
  bool clearable;

  /// true makes [input] changeable.
  /// false disables it.
  @Input('searchable')
  bool searchable = true;

  /// true will show the loading indicator of the w-input-decor located on the right hand side of it.
  @Input('loading')
  set loading(bool flag) => _decorSvc.setLoading(flag);

  /// sets the required state of [input]
  /// useful for showing the html5 form validation if set to true.
  @Input('required')
  bool isRequired = false;

  @Input('placeholder')
  String placeholder = 'Please Select';

  final _valueChange = StreamController<dynamic>();
  @Output()
  Stream<dynamic> get valueChange => _valueChange.stream;

  @ViewChild('optionsContainer')
  HtmlElement optionsContainer;

  @ViewChild('input')
  InputElement input;

  @ContentChild('optionPrefix')
  TemplateRef optionPrefix;

  @ContentChild('optionSuffix')
  TemplateRef optionSuffix;

  String _filterText;

  final WInputDecorService _decorSvc;

  bool showOptions = false;

  List<WSelectOption> get optionsWithFilter => _filterText != null
      ? options
          .where((el) => el.compareTo == null
              ? el.label.toLowerCase().contains(_filterText.toLowerCase())
              : el.compareTo(_filterText))
          .toList()
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

  num get inputWidth => input.getBoundingClientRect().width;

  /// the constructor
  WSelectComponent(this._decorSvc) {
    /// listen to decor svc
    /// show options on focus
    /// nullify value on clear
    _decorSvc.onClear.listen((ev) => _valueChange.add(null));

    // bind keys
    KeyboardEventListener('keydown', [KeyCode.ESC], (ev) => _onBlur(true),
        where: (ev) => showOptions);
    KeyboardEventListener('keydown', [KeyCode.ENTER, KeyCode.MAC_ENTER],
        (ev) => selectOption(_higlightedOption),
        where: (ev) => showOptions);
    KeyboardEventListener('keydown', [KeyCode.UP, KeyCode.DOWN], (ev) {
      ev.preventDefault();
      _changeHighlight(ev.keyCode == KeyCode.UP ? -1 : 1);
      _scrollToActive();
    }, where: (ev) => showOptions);
  }

  @override
  void ngAfterViewInit() {
    if (isRequired) input.setAttribute('required', '');
    if (!searchable) input.setAttribute('readonly', '');

    input.onFocus.listen((ev) => _onFocus());
    input.onBlur.listen((ev) => _onBlur(true));
  }

  void toggleShowOptions() => showOptions ? _onBlur(false) : _onFocus();

  void selectOption(WSelectOption o) {
    _valueChange.add(o.value);
    _onBlur(false);
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

  void _onFocus() {
    input.focus();
    _decorSvc.setFocus(true);
    showOptions = true;
    _resetHighlighted();
    _scrollToActive();
  }

  void _onBlur(bool resetInput) {
    input.blur();
    showOptions = false;
    _filterText = null;
    _decorSvc.setFocus(false);

    if (resetInput) _resetInput();
  }

  void _resetInput() async {
    await Future.delayed(Duration(milliseconds: 10));
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

  void _changeHighlight(int delta) {
    if (optionsWithFilter.isEmpty) return;
    int cur = _clamp(highlightedIdx + delta, 0, optionsWithFilter.length);
    _higlightedOption = optionsWithFilter[cur];
  }

  int _clamp(int idx, int min, int max) =>
      idx < min ? max - 1 : idx > max - 1 ? min : idx;
}
