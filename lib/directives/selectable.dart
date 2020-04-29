import 'dart:async';
import 'dart:html';
import 'package:angular/core.dart';

@Directive(selector: '[wSelectable]')
class SelectableDirective implements AfterContentInit {
  @Input('selectedItem')
  int selectedItem;

  @Input('showSelection')
  set showSelection(bool flag) {
    _el.style.display = flag ? 'block' : 'none';
  }

  final _showChanged = StreamController<bool>();
  @Output()
  Stream<bool> get showSelectionChange => _showChanged.stream;

  final Element _el;
  int _highlightedIdx;

  final _itemSelected = StreamController<int>();
  @Output()
  Stream<int> get selectedItemChange => _itemSelected.stream;

  SelectableDirective(this._el);

  @ContentChildren(SelectableItemDirective)
  List<SelectableItemDirective> items;

  @override
  void ngAfterContentInit() {
    _reset();
    // add click listener for the items
    for (int i = 0; i < items.length; i++) {
      items[i].elem.addEventListener('click', (ev) {
        _selectItem(i);
        ev.stopPropagation();
      });
    }
    // handle esc
    document.onKeyDown
        .where((ev) => ev.keyCode == KeyCode.ESC)
        .listen((ev) => showSelection = false);
    // enter key ev
    document.onKeyDown
        .where((ev) =>
            ev.keyCode == KeyCode.ENTER || ev.keyCode == KeyCode.MAC_ENTER)
        .listen((ev) => _selectItem(_highlightedIdx));
    // listen to arrow up and down events
    document.onKeyDown
        .where((ev) => ev.keyCode == KeyCode.UP || ev.keyCode == KeyCode.DOWN)
        .listen((KeyboardEvent ev) {
      if (_el.style.display != 'none') {
        int curHighlighted = _highlightedIdx ?? -1;
        int next = _clamp(curHighlighted + _delta(ev), 0, items.length - 1);
        _changeHighlight(next);
      }
    });
  }

  void _reset() {
    _highlightedIdx = selectedItem;
    if (_highlightedIdx != null && _highlightedIdx >= 0) {
      _selectItem(_highlightedIdx);
    }
  }

  void _selectItem(int idx) {
    _clear();
    _itemSelected.add(idx);
    items[idx].select();
    _changeHighlight(idx);
    _showChanged.add(false);
  }

  void _changeHighlight(int idx) {
    _clear();
    _highlightedIdx = idx;
    items[_highlightedIdx].highlight(true);
  }

  void _clear() => items.forEach((i) => i.clear());

  int _delta(KeyboardEvent k) => k.keyCode == KeyCode.UP ? -1 : 1;

  int _clamp(int idx, int min, int max) =>
      idx < min ? max : idx > max ? min : idx;
}

@Directive(selector: '[wSelectableItem]')
class SelectableItemDirective {
  @Input('wSelectableHighlighted')
  String highlightClass;

  @Input('wSelectableSelected')
  String selectedClass;

  final Element _el;

  Element get elem => _el;

  SelectableItemDirective(this._el);

  void highlight(bool flag) {
    _el.classes.toggle(highlightClass);
    if (flag) _el.scrollIntoView();
  }

  void select() => _el.classes.add(selectedClass);

  void clear() => _el.classes.removeAll([selectedClass, highlightClass]);
}
