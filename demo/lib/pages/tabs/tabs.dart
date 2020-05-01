import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(selector: 'tabs', templateUrl: 'tabs.html', directives: [
  coreDirectives,
  formDirectives,
  ngAdminDirectives,
  WDialogComponent,
  WInputComponent,
  WSpinnerComponent,
  WListComponent
])
class TabsComponent implements OnInit {
  String htmlCode = '''
  <html>
    <body>
      <p>My First Heading<p>
      <div>My first paragraph.</div>
    </body>
  </html>
  ''';

  String dartCode = '''
  import 'package:flutter/material.dart';

  void main() {
    runApp(TabBarDemo());
  }

  class TabBarDemo extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
              ),
              title: Text('Tabs Demo'),
            ),
            body: TabBarView(
              children: [
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        ),
      );
    }
  }
  ''';

  String httpDartCode;

  @override
  void ngOnInit() async {
    httpDartCode = await HttpRequest.getString(
        'https://raw.githubusercontent.com/wowsomeco/ng_dart_admin/master/demo/lib/pages/sliders/slider1.dart');
  }
}
