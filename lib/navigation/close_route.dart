// ignore_for_file: unused-code, unused-files
import 'package:flutter_demo/navigation/app_navigator.dart';

mixin CloseRoute<T> {
  AppNavigator get appNavigator;

  void close() => appNavigator.close();
}
