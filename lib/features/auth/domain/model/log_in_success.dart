import 'package:equatable/equatable.dart';
import 'package:flutter_demo/core/domain/model/displayable_success.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LogInSuccess extends Equatable implements HasDisplayableSuccess {
  const LogInSuccess({
    required this.user,
  });

  factory LogInSuccess.empty() => const LogInSuccess(
        user: User.anonymous(),
      );

  final User user;

  @override
  List<Object?> get props => [
        user,
      ];

  @override
  DisplayableSuccess displayableSuccess() => DisplayableSuccess.commonSuccess(
        appLocalizations.logInSuccessMessage,
      );

  LogInSuccess copyWith({User? user}) => LogInSuccess(
        user: user ?? this.user,
      );

  @override
  String toString() => 'LogInSuccess{user: $user}';
}
