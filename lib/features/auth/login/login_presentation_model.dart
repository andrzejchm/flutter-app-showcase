import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_success.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

typedef LogInResult = FutureResult<Either<LogInFailure, LogInSuccess>>;

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    LoginInitialParams initialParams,
  )   : _logInResult = const FutureResult.empty(),
        _username = initialParams.username,
        _password = '';

  /// Used for the copyWith method
  LoginPresentationModel._({
    required LogInResult logInResult,
    required String username,
    required String password,
  })  : _logInResult = logInResult,
        _username = username,
        _password = password;

  final LogInResult _logInResult;
  final String _username;
  final String _password;

  @override
  String get username => _username;

  @override
  String get password => _password;

  @override
  bool get isLoginEnabled => _username.isNotEmpty && _password.isNotEmpty;

  @override
  bool get isLoggingIn => _logInResult.isPending();

  LoginPresentationModel copyWith({
    LogInResult? logInResult,
    String? username,
    String? password,
  }) {
    return LoginPresentationModel._(
      logInResult: logInResult ?? _logInResult,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  String get username;
  String get password;

  bool get isLoginEnabled;
  bool get isLoggingIn;
}
