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
  )   : username = '',
        password = '',
        result = const FutureResult.empty();

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.username,
    required this.password,
    required this.result,
  });

  final String username;
  final String password;
  final FutureResult<Either<LoginFailure, User>> result;

  @override
  bool get isLoginButtonEnabled => username.isNotEmpty && password.isNotEmpty;

  @override
  bool get isLoading => result.isPending();

  LoginPresentationModel copyWith({
    String? username,
    String? password,
    FutureResult<Either<LoginFailure, User>>? result,
  }) {
    return LoginPresentationModel._(
      username: username ?? this.username,
      password: password ?? this.password,
      result: result ?? this.result,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoading;

  bool get isLoginButtonEnabled;
}
