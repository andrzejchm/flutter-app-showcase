import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  )   : logInResult = const FutureResult.empty(),
        user = const User.anonymous(),
        loginEnabled = false;

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.logInResult,
    required this.user,
    required this.loginEnabled,
  });

  final FutureResult<Either<LogInFailure, User>> logInResult;
  final bool loginEnabled;
  final User user;

  @override
  bool get isLoginEnabled => loginEnabled;

  @override
  bool get isLoading => logInResult.isPending();

  LoginPresentationModel copyWith({
    FutureResult<Either<LogInFailure, User>>? logInResult,
    User? user,
    bool? loginEnabled,
  }) {
    return LoginPresentationModel._(
      logInResult: logInResult ?? this.logInResult,
      user: user ?? this.user,
      loginEnabled: loginEnabled ?? this.loginEnabled,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoginEnabled;
  bool get isLoading;
}
