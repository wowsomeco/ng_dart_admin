import 'dart:async';
import 'dart:html';
import 'package:angular/core.dart';

@Directive(selector: '[wSelectable]')
class SelectableDirective implements AfterContentInit {
  @Input('selectedItem')
  int selectedItem;

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
      items[i].elem.addEventListener('click', (ev) => _selectItem(i));
    }
    // enter key ev
    document.onKeyDown
        .where((ev) =>
            ev.keyCode == KeyCode.ENTER || ev.keyCode == KeyCode.MAC_ENTER)
        .listen((ev) => _selectItem(_highlightedIdx));
    // listen to arrow up and down events
    document.onKeyDown
        .where((KeyboardEvent ev) =>
            ev.keyCode == KeyCode.UP || ev.keyCode == KeyCode.DOWN)
        .listen((KeyboardEvent ev) {
      if (_el.style.display != 'none') {
        _changeHighlight(
            (_highlightedIdx + _delta(ev)).clamp(0, items.length - 1));
      }
    });
  }

  void _reset() {
    _highlightedIdx = selectedItem;
    items[_highlightedIdx].highlight(true);
    items[_highlightedIdx].select();
  }

  void _selectItem(int idx) {
    items[selectedItem].select();
    _itemSelected.add(idx);
    items[idx].select();
    _changeHighlight(idx);
  }

  void _changeHighlight(int idx) {
    items[_highlightedIdx].highlight(false);
    _highlightedIdx = idx;
    items[_highlightedIdx].highlight(true);
  }

  int _delta(KeyboardEvent k) => k.keyCode == KeyCode.UP ? -1 : 1;
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

  void highlight(bool flag) => _el.classes.toggle(highlightClass);

  void select() => _el.classes.toggle(selectedClass);
}
