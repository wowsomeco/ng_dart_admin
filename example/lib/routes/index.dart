import 'package:angular_router/angular_router.dart';
import 'package:ng_admin_demo/pages/dashboard/dashboard.template.dart'
    as dashboard_template;
import 'package:ng_admin_demo/pages/layouts/layouts.template.dart'
    as layouts_template;
import 'package:ng_admin_demo/pages/tables/tables.template.dart'
    as tables_template;
import 'package:ng_admin_demo/pages/charts/chartist/chartists.template.dart'
    as chartists_template;
import 'package:ng_admin_demo/pages/charts/frappe/frappes.template.dart'
    as frappes_template;
import 'package:ng_admin_demo/pages/maps/maps.template.dart' as maps_template;
import 'package:ng_admin_demo/pages/forms/forms.template.dart'
    as forms_template;
import 'package:ng_admin_demo/pages/sliders/sliders.template.dart'
    as sliders_template;
import 'package:ng_admin_demo/pages/tabs/tabs.template.dart' as tabs_template;
import 'package:ng_admin_demo/pages/lists/lists.template.dart'
    as lists_template;
import 'package:ng_admin_demo/pages/calendar/calendars.template.dart'
    as calendars_template;

class RoutePaths {
  static final dashboard = RoutePath(path: 'dashboard');
  static final layouts = RoutePath(path: 'layouts');
  static final tables = RoutePath(path: 'tables');
  static final chartist = RoutePath(path: 'chartist');
  static final frappe = RoutePath(path: 'frappe');
  static final maps = RoutePath(path: 'maps');
  static final forms = RoutePath(path: 'forms');
  static final sliders = RoutePath(path: 'sliders');
  static final tabs = RoutePath(path: 'tabs');
  static final lists = RoutePath(path: 'lists');
  static final calendars = RoutePath(path: 'calendars');
}

class Routes {
  static final all = [
    RouteDefinition(
        routePath: RoutePaths.dashboard,
        component: dashboard_template.DashboardComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.layouts,
        component: layouts_template.LayoutsComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.tables,
        component: tables_template.TablesComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.chartist,
        component: chartists_template.ChartistsComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.frappe,
        component: frappes_template.FrappesComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.maps,
        component: maps_template.MapsComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.forms,
        component: forms_template.FormsComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.sliders,
        component: sliders_template.SlidersComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.tabs,
        component: tabs_template.TabsComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.lists,
        component: lists_template.ListsComponentNgFactory),
    RouteDefinition(
        routePath: RoutePaths.calendars,
        component: calendars_template.CalendarsComponentNgFactory),
  ];
}
