import 'dart:html';
import 'package:angular/core.dart';

@Directive(selector: '[wTabs]')
class WTabsDirective implements AfterContentInit {
  @ContentChildren(WTabBarDirective, descendants: false)
  List<WTabBarDirective> tabBars;

  @ContentChildren(WTabViewDirective, descendants: false)
  List<WTabViewDirective> tabViews;

  @override
  void ngAfterContentInit() {
    assert(tabBars.length == tabViews.length,
        'tabBars.length (${tabBars.length}) doesnt match with tabViews.length (${tabViews.length})');

    for (int i = 0; i < tabBars.length; i++) {
      tabBars[i].initTabBar(this, i);
    }

    /// default active to 0th idx
    select(0);
  }

  void select(int idx) {
    for (int i = 0; i < tabBars.length; i++) {
      bool shouldShow = i == idx;
      tabBars[i].select(shouldShow);
      tabViews[i].show(shouldShow);
    }
  }
}

@Directive(selector: '[wTabBar]')
class WTabBarDirective {
  /// css classes to activate on selected
  @Input('tabSelectClass')
  String selectedClass = 'active';

  final Element _el;

  WTabBarDirective(this._el);

  void select(bool flag) {
    List<String> selected = selectedClass.split(' ');
    flag ? _el.classes.addAll(selected) : _el.classes.removeAll(selected);
  }

  void initTabBar(WTabsDirective controller, int idx) =>
      _el.onClick.listen((ev) {
        ev.stopPropagation();
        controller.select(idx);
      });
}

@Directive(selector: '[wTabView]')
class WTabViewDirective {
  final Element _el;

  WTabViewDirective(this._el);

  void show(bool flag) => _el.style.display = flag ? 'block' : 'none';
}
