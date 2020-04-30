import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Injectable()
class WLayoutService {
  bool _collapsed = false;
  set collapsed(bool flag) {
    _collapsed = flag;
    _collapsedChange.add(_collapsed);
  }

  bool get collapsed => _collapsed;

  final _collapsedChange = StreamController<bool>.broadcast();
  Stream<bool> get collapsedChange => _collapsedChange.stream;
}

/// The default layout for ng_admin.
/// It consists of 3 sections i.e w-header, w-sidebar, and w-main
@Component(
    selector: 'w-layout',
    templateUrl: 'w_layout.html',
    directives: [coreDirectives, routerDirectives],
    providers: [ClassProvider(WLayoutService)])
class WLayoutComponent {
  bool get collapsed => _layoutSvc.collapsed;
  set collapsed(bool flag) => _layoutSvc.collapsed = flag;

  final WLayoutService _layoutSvc;

  WLayoutComponent(this._layoutSvc);
}
