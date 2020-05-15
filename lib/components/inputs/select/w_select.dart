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

/// The adapter for the w-select
class WSelectAdapter<T> {
  /// will be called on init of w-select.
  /// this handles the case where sometimes the options need to be fetched asynchronously
  /// e.g. from the backend via http request, etc.
  final Future<List<WSelectOption<T>>> Function() fetchOptions;

  WSelectAdapter({this.fetchOptions});
}

@Component(
  selector: 'w-select',
  templateUrl: 'w_select.html',
  providers: [ClassProvider(WInputDecorService), ClassProvider(WSelectService)],
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
    WInputDecoratorComponent,
    WSelectDirective,
    WSelectItemDirective
  ],
)
class WSelectComponent implements OnInit {
  @Input('adapter')
  WSelectAdapter adapter;

  @Input('value')
  dynamic value;

  @Input('clearable')
  bool clearable;

  final _valueChange = StreamController<dynamic>();
  @Output()
  Stream<dynamic> get valueChange => _valueChange.stream;

  List<WSelectOption> options = [];

  final WInputDecorService _decorSvc;
  final WSelectService _selectSvc;

  set showOptions(bool flag) => _selectSvc.showing = flag;
  bool get showOptions => _selectSvc.showing;

  int get selectedItemIdx =>
      value != null ? options.indexWhere((x) => x.value == value) : null;

  String get selectedLabel => selectedItemIdx != null && selectedItemIdx >= 0
      ? options[selectedItemIdx].label
      : null;

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
      ..showingStream.listen((ev) => _decorSvc.setFocus(ev))
      ..selectItemStream.listen(
          (ev) => _valueChange.add(ev == null ? null : options[ev].value));
  }

  @override
  void ngOnInit() async {
    await _fetchOptions();
    // set value
    _selectSvc.selectItem = selectedItemIdx;
    if (value != null) {
      assert(
          selectedItemIdx > -1, 'value=$value does not exist in the options');
    }
  }

  void _fetchOptions() async {
    /// fetch options, show loading
    /// hide loading on done
    if (adapter != null) {
      _decorSvc.setLoading(true);
      options = await adapter.fetchOptions();
      _decorSvc.setLoading(false);
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

@Directive(selector: '[wSelectable]')
class WSelectDirective implements AfterContentInit {
  int _highlightedIdx;

  @ContentChildren(WSelectItemDirective)
  List<WSelectItemDirective> items;

  final WSelectService _service;
  final Element _el;

  WSelectDirective(this._service, this._el) {
    /// listen to the svc
    _service.showingStream.listen((ev) {
      if (ev) _focus();
    });
  }

  @override
  void ngAfterContentInit() {
    // add click listener for the items
    for (int i = 0; i < items.length; i++) {
      items[i].elem.addEventListener('click', (ev) {
        _select(i);
        ev
          ..stopPropagation()
          ..preventDefault();
      });
    }
    // handle esc
    document.onKeyDown
      ..where((ev) =>
              _service.showing &&
              (ev.keyCode == KeyCode.ENTER || ev.keyCode == KeyCode.MAC_ENTER))
          .listen((ev) => _select(_highlightedIdx))
      ..where((ev) =>
              _service.showing &&
              (ev.keyCode == KeyCode.UP || ev.keyCode == KeyCode.DOWN))
          .listen((KeyboardEvent ev) {
        ev.preventDefault();
        int curHighlighted = _highlightedIdx ?? -1;
        int next = _clamp(curHighlighted + _delta(ev), 0, items.length - 1);
        _changeHighlight(next);
      });

    _service.showing = false;
  }

  void _changeHighlight(int idx) {
    if (_highlightedIdx != null) items[_highlightedIdx].highlight(false);
    _highlightedIdx = idx;
    if (idx != null) items[_highlightedIdx].highlight(true);
    _scrollToActive();
  }

  void _select(int idx) {
    _service.selectItem = idx;
    items[idx].select();
  }

  void _focus() {
    _highlightedIdx = _service.selectItem;
    _clear();
    if (_service.selectItem != null) {
      items[_service.selectItem]
        ..select()
        ..highlight(true);
    }
    _scrollToActive();
  }

  void _scrollToActive() {
    if (_highlightedIdx != null) {
      var myRect = _el.getBoundingClientRect();
      var itemRect = items[_highlightedIdx].elem.getBoundingClientRect();
      _el.scrollTop = itemRect.top + _el.scrollTop - myRect.top;
    }
  }

  void _clear() => items.forEach((i) => i.clear());

  int _delta(KeyboardEvent k) => k.keyCode == KeyCode.UP ? -1 : 1;

  int _clamp(int idx, int min, int max) =>
      idx < min ? max : idx > max ? min : idx;
}

@Directive(selector: '[wSelectItem]')
class WSelectItemDirective {
  final Element elem;

  final String _highlighted = 'bg-light-gray';
  final String _selected = 'blue';

  WSelectItemDirective(this.elem);

  void highlight(bool flag) =>
      flag ? elem.classes.add(_highlighted) : elem.classes.remove(_highlighted);

  void select() => elem.classes.add(_selected);
  void clear() => elem.classes.removeAll([_highlighted, _selected]);
}
