import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';

class LoginPresentationModel implements LoginViewModel {
  LoginPresentationModel.initial()
      : loginResult = const FutureResult.empty(),
        username = "",
        password = "";

  LoginPresentationModel._(
    this.loginResult,
    this.username,
    this.password,
  );

  final FutureResult<Either<LogInFailure, User>> loginResult;

  @override
  final String password;

  @override
  final String username;

  @override
  bool get isLoginEnabled => username.isNotEmpty && password.isNotEmpty;

  @override
  bool get showLoading => loginResult.isPending();

  LoginPresentationModel copyWith({
    FutureResult<Either<LogInFailure, User>>? loginResult,
    bool? isLoadingButtonEnabled,
    String? username,
    String? password,
  }) {
    return LoginPresentationModel._(
      loginResult ?? this.loginResult,
      username ?? this.username,
      password ?? this.password,
    );
  }
}

abstract class LoginViewModel {
  String get username;

  String get password;

  bool get isLoginEnabled;

  bool get showLoading;
}
