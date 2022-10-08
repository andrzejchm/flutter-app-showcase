import 'package:flutter_demo/core/domain/model/displayable_failure.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const LoginFailure.unknown([this.cause]) : type = LogInFailureType.unknown;

  const LoginFailure.missingCredentials([this.cause]) : type = LogInFailureType.missingCredentials;

  final LogInFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LogInFailureType.unknown:
        return DisplayableFailure.commonError();
      case LogInFailureType.missingCredentials:
        return DisplayableFailure(
          title: appLocalizations.missingCredsTitle,
          message: appLocalizations.missingCredsMessage,
        );
    }
  }

  @override
  String toString() => 'LogInFailure{type: $type, cause: $cause}';
}

enum LogInFailureType {
  unknown,
  missingCredentials,
}
