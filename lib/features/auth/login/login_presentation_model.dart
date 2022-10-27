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
  )   : loginResult = const FutureResult.empty(),
        uname = '',
        passwd = '';

  LoginPresentationModel._({
    required this.uname,
    required this.passwd,
    required this.loginResult,
  });

  final String uname;
  final String passwd;
  final FutureResult<Either<LogInFailure, User>> loginResult;

  @override
  bool get isLoginEnabled => password.isNotEmpty && username.isNotEmpty;

  @override
  String get password => passwd;

  @override
  String get username => uname;

  @override
  bool get isLoading => loginResult.isPending();

  LoginPresentationModel copyWith({
    String? username,
    String? password,
    FutureResult<Either<LogInFailure, User>>? loginResult,
  }) {
    return LoginPresentationModel._(
      uname: username ?? uname,
      passwd: password ?? passwd,
      loginResult: loginResult ?? this.loginResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoginEnabled;
  bool get isLoading;
  String get username;
  String get password;
}
