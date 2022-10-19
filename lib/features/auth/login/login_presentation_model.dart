import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Used for the copyWith method
  LoginPresentationModel._(
    this.username,
    this.password,
    this.logInResult,
  );

  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams, {
    this.username = '',
    this.password = '',
    this.logInResult = const FutureResult.empty(),
  });

  final String username;
  final String password;
  final FutureResult<Either<LogInFailure, User>> logInResult;

  @override
  bool get isLoginEnabled => username.isNotEmpty && password.isNotEmpty && !logInResult.isPending();

  @override
  bool get isLoading => logInResult.isPending();

  //TODO: could be used frezzed
  LoginPresentationModel copyWith({
    String? username,
    String? password,
    FutureResult<Either<LogInFailure, User>>? logInResult,
  }) {
    return LoginPresentationModel._(
      username ?? this.username,
      password ?? this.password,
      logInResult ?? this.logInResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoading;

  bool get isLoginEnabled;
}
