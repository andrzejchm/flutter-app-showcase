import 'package:flutter/material.dart';
import 'package:flutter_demo/core/helpers.dart';
import 'package:flutter_demo/core/utils/durations.dart';
import 'package:flutter_demo/navigation/transitions/fade_in_page_transition.dart';
import 'package:flutter_demo/navigation/transitions/slide_bottom_page_transition.dart';

class AppNavigator {
  AppNavigator() {
    suppressUnusedCodeWarning([fadeInRoute, slideBottomRoute]);
  }

  static final navigatorKey = GlobalKey<NavigatorState>();

  Future<R?> push<R>(
    Route<R> route, {
    BuildContext? context,
    bool useRoot = false,
  }) async {
    return _navigator(context, useRoot: useRoot).push(route);
  }

  Future<R?> pushReplacement<R>(
    Route<R> route, {
    BuildContext? context,
    bool useRoot = false,
  }) async {
    return _navigator(context, useRoot: useRoot).pushReplacement(route);
  }

  void close({
    BuildContext? context,
  }) =>
      closeWithResult(null, context: context);

  void closeWithResult<T>(
    T result, {
    BuildContext? context,
  }) =>
      _navigator(context).canPop() ? _navigator(context).pop(result) : result;

  void popUntilRoot(BuildContext context) => _navigator(context).popUntil((route) => route.isFirst);

  void popUntilPageWithName(
    String title, {
    BuildContext? context,
  }) =>
      _navigator(context).popUntil(ModalRoute.withName(title));
}

//ignore: long-parameter-list
Route<T> fadeInRoute<T>(
  Widget page, {
  int? durationMillis,
  String? pageName,
  bool opaque = true,
  bool fadeOut = true,
}) =>
    PageRouteBuilder<T>(
      opaque: opaque,
      transitionDuration: Duration(
        milliseconds: durationMillis ?? Durations.medium,
      ),
      settings: RouteSettings(name: pageName ?? page.runtimeType.toString()),
      pageBuilder: _pageBuilder(page),
      transitionsBuilder: fadeInPageTransition(fadeOut: fadeOut),
    );

//ignore: long-parameter-list, unused-code
Route<T> noTransitionRoute<T>(
  Widget page, {
  int? durationMillis,
  String? pageName,
  bool opaque = true,
}) =>
    PageRouteBuilder<T>(
      opaque: opaque,
      transitionDuration: Duration.zero,
      settings: RouteSettings(name: pageName ?? page.runtimeType.toString()),
      pageBuilder: _pageBuilder(page),
    );

Route<T> materialRoute<T>(
  Widget page, {
  bool fullScreenDialog = false,
  String? pageName,
}) =>
    MaterialPageRoute(
      builder: (context) => page,
      settings: RouteSettings(name: pageName ?? page.runtimeType.toString()),
      fullscreenDialog: fullScreenDialog,
    );

//ignore: long-parameter-list
Route<T> slideBottomRoute<T>(
  Widget page, {
  int? durationMillis,
  bool fullScreenDialog = false,
  String? pageName,
  bool opaque = true,
}) =>
    PageRouteBuilder<T>(
      opaque: opaque,
      transitionDuration: Duration(
        milliseconds: durationMillis ?? Durations.medium,
      ),
      fullscreenDialog: fullScreenDialog,
      settings: RouteSettings(name: pageName ?? page.runtimeType.toString()),
      pageBuilder: _pageBuilder(page),
      transitionsBuilder: slideBottomPageTransition(),
    );

RoutePageBuilder _pageBuilder(Widget page) => (
      context,
      animation,
      secondaryAnimation,
    ) =>
        page;

NavigatorState _navigator(BuildContext? context, {bool useRoot = false}) =>
    (useRoot || context == null) ? AppNavigator.navigatorKey.currentState! : Navigator.of(context);
