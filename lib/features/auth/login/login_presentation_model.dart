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
        appLoginResult = const FutureResult.empty();

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.username,
    required this.password,
    required this.appLoginResult,
  });

  final String username;
  final String password;
  final FutureResult<Either<LogInFailure, User>> appLoginResult;

  @override
  String get getUser => username;

  @override
  String get getPassword => password;

  @override
  bool get isLoginEnabled => username.isNotEmpty && password.isNotEmpty;

  @override
  bool get isLoading => appLoginResult.isPending();

  LoginPresentationModel copyWith({
    String? username,
    String? password,
    FutureResult<Either<LogInFailure, User>>? appLoginResult,
  }) =>
      LoginPresentationModel._(
        username: username ?? this.username,
        password: password ?? this.password,
        appLoginResult: appLoginResult ?? this.appLoginResult,
      );
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  String get getUser;
  String get getPassword;
  bool get isLoginEnabled;
  bool get isLoading;
}
