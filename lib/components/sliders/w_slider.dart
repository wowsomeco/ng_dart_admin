import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(
  selector: 'w-slider',
  templateUrl: 'w_slider.html',
  directives: [coreDirectives, ngAdminDirectives],
)
class WSliderComponent implements OnInit {
  /// px
  @Input('height')
  num height = 5;

  /// 0 to 100
  @Input('value')
  set value(num v) => _value = v;
  num get value => _value ?? 0;
  num _value;

  final _valueChange = StreamController<num>();
  @Output()
  Stream<num> get valueChange => _valueChange.stream;

  @Input('steps')
  List<dynamic> steps = [];

  @Input('bgColor')
  String bgColor = 'light-gray';

  String get bgCol => 'bg-$bgColor';

  @Input('valueColor')
  String valueColor = 'light-blue';

  String get valCol => 'bg-$valueColor';

  @ContentChild('step')
  TemplateRef step;

  @ViewChild('slider')
  HtmlElement slider;

  final ChangeDetectorRef _changeDetectorRef;
  final WLayoutService _layoutService;

  WSliderComponent(this._changeDetectorRef, this._layoutService) {
    /// hacky way to re-pos the slider indicator dot.
    /// might want to come up with a better idea eventually.
    _layoutService.collapsedChange.listen((ev) async {
      await Future.delayed(Duration(milliseconds: 10));
      _changeDetectorRef.markForCheck();
    });
  }

  num get valuePercentage => value / 100;

  Map<String, String> get sliderStyle =>
      {'transform-origin': 'top left', 'transform': 'scaleX($valuePercentage)'};

  Map<String, String> get progressDotStyle =>
      {'transform': 'translate(${slideDotOffsetX}px, -${height / 2}px)'};

  num get dotSize => height * 2;

  String get textClass => 'gray f6';

  Rectangle<num> get sliderRect => slider.getBoundingClientRect();

  num get slideDotOffsetX => valuePercentage * sliderRect.width - height;

  void handleSwiping(Point<num> point) {
    num percentage =
        (((point.x - sliderRect.left) / sliderRect.width).clamp(0, 1) * 100)
            .roundToDouble();

    /// for better performance
    if ((percentage - value).abs() > 0.9) _valueChange.add(percentage);
  }

  @override
  void ngOnInit() {
    window
      ..onDeviceOrientation.listen((v) => _changeDetectorRef.markForCheck())
      ..onResize.listen((v) => _changeDetectorRef.markForCheck());
  }
}
