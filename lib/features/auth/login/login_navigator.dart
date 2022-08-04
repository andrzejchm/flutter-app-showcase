import 'package:flutter_demo/dependency_injection/app_component.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_page.dart';
import 'package:flutter_demo/navigation/app_navigator.dart';
import 'package:flutter_demo/navigation/no_routes.dart';

class LoginNavigator with NoRoutes {
  LoginNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

//ignore: unused-code
mixin LoginRoute {
  Future<void> openLogin(LoginInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<LoginPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
