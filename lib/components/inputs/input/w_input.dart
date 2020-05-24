import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

/// The input component that wraps the native <input> tag on [WInputDecoratorComponent].
///
/// use this component as an alternative to the <input> if you feel like having more customization e.g. loading indicator, clear icon, etc.
@Component(
  selector: 'w-input',
  styleUrls: ['w_input.css'],
  templateUrl: 'w_input.html',
  providers: [ClassProvider(WInputDecorService)],
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
    WInputDecoratorComponent
  ],
)
class WInputComponent implements AfterViewInit {
  @Input('value')
  dynamic value;

  @Input('type')
  String type = 'text';

  @Input('required')
  bool isRequired = false;

  @Input('readonly')
  bool readonly = false;

  @Input('clearable')
  bool clearable;

  @Input('placeholder')
  String placeholder;

  @ViewChild('input')
  HtmlElement input;

  final _valueChange = StreamController<dynamic>();
  @Output()
  Stream<dynamic> get valueChange => _valueChange.stream;
  void setValue(dynamic v) {
    /// just directly return null value if empty
    if (v == null || v.toString().isEmpty) {
      _valueChange.add(null);
      return;
    }

    /// check and parse accordingly
    switch (type) {
      case 'number':
        _valueChange.add(num.parse(v));
        break;
      default:
        _valueChange.add(v);
        break;
    }
  }

  final WInputDecorService _service;

  WInputComponent(this._service) {
    _service.focus.listen((ev) => ev ? input.focus() : input.blur());
    _service.onClear.listen((ev) => setValue(null));
  }

  @override
  void ngAfterViewInit() {
    if (isRequired) input.setAttribute('required', '');
    if (readonly) input.setAttribute('readonly', '');

    input.onFocus.listen((event) => _service.setFocus(true));
    input.onBlur.listen((event) => _service.setFocus(false));
  }
}
