import 'package:angular_router/angular_router.dart';
import 'package:ng_admin_demo/pages/dashboard/dashboard.template.dart'
    as dashboard_template;
import 'package:ng_admin_demo/pages/tables/tables.template.dart'
    as tables_template;
import 'package:ng_admin_demo/pages/charts/charts.template.dart'
    as charts_template;
import 'package:ng_admin_demo/pages/maps/maps.template.dart' as maps_template;
import 'package:ng_admin_demo/pages/forms/forms.template.dart'
    as forms_template;
import 'package:ng_admin_demo/pages/sliders/sliders.template.dart'
    as sliders_template;

class RoutePaths {
  static final dashboard =
      RoutePath(path: 'dashboard', additionalData: {'icon': 'dashboard'});
  static final tables =
      RoutePath(path: 'tables', additionalData: {'icon': 'border_all'});
  static final charts =
      RoutePath(path: 'charts', additionalData: {'icon': 'bar_chart'});
  static final maps =
      RoutePath(path: 'maps', additionalData: {'icon': 'layers'});
  static final forms =
      RoutePath(path: 'forms', additionalData: {'icon': 'event_note'});
  static final sliders =
      RoutePath(path: 'sliders', additionalData: {'icon': 'timeline'});
}

class Routes {
  static final all = [
    RouteDefinition(
        routePath: RoutePaths.dashboard,
        component: dashboard_template.DashboardComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.tables,
        component: tables_template.TablesComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.charts,
        component: charts_template.ChartsComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.maps,
        component: maps_template.MapsComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.forms,
        component: forms_template.FormsComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.sliders,
        component: sliders_template.SlidersComponentNgFactory),
  ];
}
