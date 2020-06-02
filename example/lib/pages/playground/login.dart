import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_admin/ng_admin.dart';

@Component(
  selector: 'login',
  templateUrl: 'login.html',
  directives: [
    coreDirectives,
    formDirectives,
    ngAdminDirectives,
    WButtonComponent,
    WInputComponent
  ],
)
class LoginComponent {
  String username;
  String password;
  bool loggingIn = false;

  void login() async {
    loggingIn = true;
    await Future.delayed(Duration(seconds: 1));
    loggingIn = false;
  }
}
