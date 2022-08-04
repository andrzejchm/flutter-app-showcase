import 'package:flutter/foundation.dart';

/// allows for specifying global error logger for the app. you can replace it with something 'harmless' for testing
// ignore: prefer_function_declarations_over_variables
void Function(
  dynamic error,
  dynamic stack,
  String? reason,
) errorLogger = (
  error,
  stack,
  reason,
) {
  // TODO add firebase crashlytics or equivalent logging here
  debugLog(
    'ERROR ${reason == null ? '' : ': $reason'}\n'
    '================\n'
    'error: $error\n'
    'stack: $stack\n'
    '================\n',
  );
};

void logError(
  dynamic error, [
  dynamic stack,
  String? reason,
]) =>
    errorLogger(
      error,
      stack,
      reason,
    );

void debugLog(
  String message, [
  dynamic caller,
]) {
  debugPrint(caller == null ? message : '${caller.runtimeType}: $message');
}
