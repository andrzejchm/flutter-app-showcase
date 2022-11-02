import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/navigation/app_navigator.dart';
import 'package:flutter_demo/navigation/error_dialog_route.dart';
import 'package:flutter_demo/navigation/no_routes.dart';

class AppInitNavigator with NoRoutes, ErrorDialogRoute, LoginRoute {
  AppInitNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}
