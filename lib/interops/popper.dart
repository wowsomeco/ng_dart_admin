@JS()
library tippy_interop;

import 'dart:html';
import 'package:js/js.dart';

@JS()
external PopperInterface get Popper;

@JS()
class PopperInterface {
  external PopperInstance createPopper(
      Element ref, Element target, PopperConfig config);
}

@JS()
class PopperInstance {
  external void destroy();
}

@anonymous
@JS()
class PopperConfig {
  external String get placement;
  external PopperModifier get modifiers;
  external String get strategy;

  external factory PopperConfig(
      {String placement, PopperModifier modifiers, String strategy});
}

@anonymous
@JS()
class PopperModifier {
  external PopperFlip get flip;
  external List<num> get offset;
  external PopperPreventOverflow get preventOverflow;

  external factory PopperModifier(
      {PopperFlip flip,
      List<num> offset = const [0, 0],
      PopperPreventOverflow preventOverflow});
}

@anonymous
@JS()
class PopperFlip {
  external bool get enabled;

  external factory PopperFlip({bool enabled});
}

@anonymous
@JS()
class PopperPreventOverflow {
  external bool get mainAxis;
  external bool get altAxis;
  external int get padding;
  external dynamic get boundary;
  external bool get altBoundary;
  external dynamic get rootBoundary;
  external bool get tether;
  external int get tetherOffset;

  external factory PopperPreventOverflow(
      {bool mainAxis = true,
      bool altAxis = false,
      int padding = 0,
      dynamic boundary = 'clippingParents',
      bool altBoundary = false,
      dynamic rootBoundary = 'viewport',
      bool tether = true,
      int tetherOffset = 0});
}
