import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:ng_admin_demo/app_component.template.dart' as ng;

import 'main.template.dart' show injector$Injector;

const useHashLS = false;
@GenerateInjector(routerProvidersHash)
final InjectorFactory injector = injector$Injector;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}
