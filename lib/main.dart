// ignore_for_file: unused-code
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/helpers.dart';
import 'package:flutter_demo/dependency_injection/app_component.dart';
import 'package:flutter_demo/flutter_demo_app.dart';
import 'package:flutter_demo/navigation/close_with_result_route.dart';

/// flag modified by unit tests so that app's code can adapt to unit tests
/// (i.e: disable animations in progress bars etc.)
bool isUnitTests = false;

void main() {
  configureDependencies();
  _suppressUnusedCodeWarnings(); // used in tests
  runApp(const FlutterDemoApp());
}

/// hacky way to get rid of false-positive `unused-code` warnings from dart_code_metrics
/// https://github.com/dart-code-checker/dart-code-metrics/pull/929
void _suppressUnusedCodeWarnings() {
  suppressUnusedCodeWarning([
    notImplemented,
    CloseWithResultRoute,
  ]);
}
