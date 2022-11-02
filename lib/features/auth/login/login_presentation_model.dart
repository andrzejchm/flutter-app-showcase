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
  ) : loginUseCase = const FutureResult.empty();

  /// Used for the copyWith method
  LoginPresentationModel._({required this.loginUseCase});

  final FutureResult<Either<LogInFailure, User>> loginUseCase;

  //Implemented LoginViewModel private Values
  String _username = '';
  String _password = '';

  @override
  String get username => _username;

  @override
  String get password => _password;

  @override
  bool get signInButtonEnabled => _username.trim().isNotEmpty && _password.trim().isNotEmpty;

  @override
  bool get isLoading => loginUseCase.isPending();

  LoginPresentationModel copyWith({
    FutureResult<Either<LogInFailure, User>>? loginUseCase,
  }) {
    return LoginPresentationModel._(
      loginUseCase: loginUseCase ?? this.loginUseCase,
    );
  }

  void usernameChanged({required String user}) {
    _username = user;
  }

  void passwordChanged({required String password}) {
    _password = password;
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoading;
  bool get signInButtonEnabled;
  String get username;
  String get password;
}
