import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

class WSelectOption<T> {
  final String label;
  final T value;

  WSelectOption(this.label, this.value);
}

@Component(
  selector: 'w-select',
  templateUrl: 'w_select.html',
  providers: [ClassProvider(WInputDecorService), ClassProvider(WSelectService)],
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
    WInputDecoratorComponent
  ],
)
class WSelectComponent implements OnInit {
  @Input('options')
  List<WSelectOption> options = [];

  @Input('value')
  dynamic value;

  @Input('clearable')
  bool clearable;

  @Input('loading')
  set loading(bool flag) => _decorSvc.setLoading(flag);

  final _valueChange = StreamController<dynamic>();
  @Output()
  Stream<dynamic> get valueChange => _valueChange.stream;

  @ViewChild('optionsContainer')
  HtmlElement optionsContainer;

  final WInputDecorService _decorSvc;
  final WSelectService _selectSvc;

  set showOptions(bool flag) => _selectSvc.showing = flag;
  bool get showOptions => _selectSvc.showing;

  int get selectedItemIdx =>
      value != null ? options.indexWhere((x) => x.value == value) : null;

  String get selectedLabel => selectedItemIdx != null && selectedItemIdx >= 0
      ? options[selectedItemIdx].label
      : null;

  int _highlightedIdx;

  /// the constructor
  WSelectComponent(this._decorSvc, this._selectSvc) {
    /// listen to decor svc
    /// show options on focus
    /// nullify value on clear
    _decorSvc
      ..focus.listen((ev) => _selectSvc.showing = ev)
      ..onClear.listen((ev) {
        _valueChange.add(null);
        _selectSvc.selectItem = null;
      });

    /// listen to select svc
    /// set value on selected item
    _selectSvc
      ..showingStream.listen((ev) {
        _decorSvc.setFocus(ev);
        if (ev) _scrollToActive();
      })
      ..selectItemStream.listen(
          (ev) => _valueChange.add(ev == null ? null : options[ev].value));
  }

  @override
  void ngOnInit() {
    // set value
    _selectSvc.selectItem = selectedItemIdx;
    if (value != null) {
      assert(
          selectedItemIdx > -1, 'value=$value does not exist in the options');
    }
    // bind keys
    document.onKeyDown
      ..where((ev) =>
              _selectSvc.showing &&
              (ev.keyCode == KeyCode.ENTER || ev.keyCode == KeyCode.MAC_ENTER))
          .listen((ev) => selectOption(_highlightedIdx))
      ..where((ev) =>
              _selectSvc.showing &&
              (ev.keyCode == KeyCode.UP || ev.keyCode == KeyCode.DOWN))
          .listen((KeyboardEvent ev) {
        ev.preventDefault();
        int curHighlighted = _highlightedIdx ?? -1;
        int next = _clamp(curHighlighted + _delta(ev), 0, options.length - 1);
        _highlightedIdx = next;
        _scrollToActive();
      });
  }

  void selectOption(int idx) {
    _selectSvc.selectItem = idx;
  }

  Map<String, bool> getOptionItemClasses(int idx) =>
      {'bg-light-gray': idx == _highlightedIdx, 'blue': idx == selectedItemIdx};

  int _delta(KeyboardEvent k) => k.keyCode == KeyCode.UP ? -1 : 1;

  int _clamp(int idx, int min, int max) =>
      idx < min ? max : idx > max ? min : idx;

  void _scrollToActive() {
    if (_highlightedIdx != null && _highlightedIdx >= 0) {
      // right now it is hardcoded to 50 px, might want to fix this later.
      optionsContainer.scrollTop = (_highlightedIdx * 50);
    }
  }
}

@Injectable()
class WSelectService {
  int _selectItem;
  int get selectItem => _selectItem;
  set selectItem(int idx) {
    _selectItem = idx;
    _selectItemChange.add(idx);
    showing = false;
  }

  final _selectItemChange = StreamController<int>.broadcast();
  Stream<int> get selectItemStream => _selectItemChange.stream;

  bool _showing = false;
  bool get showing => _showing;
  set showing(bool flag) {
    _showing = flag;
    _showingChange.add(flag);
  }

  final _showingChange = StreamController<bool>.broadcast();
  Stream<bool> get showingStream => _showingChange.stream;
}
