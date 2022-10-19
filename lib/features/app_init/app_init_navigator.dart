import 'package:flutter_demo/navigation/app_navigator.dart';
import 'package:flutter_demo/navigation/error_dialog_route.dart';
import 'package:flutter_demo/navigation/no_routes.dart';

typedef AppInitSuccess = void Function(AppNavigator navigator);

class AppInitNavigator with NoRoutes, ErrorDialogRoute {
  AppInitNavigator(this.appNavigator, this.onSuccess);

  final AppInitSuccess onSuccess;

  @override
  final AppNavigator appNavigator;

  void performSuccess() => onSuccess(appNavigator);
}
