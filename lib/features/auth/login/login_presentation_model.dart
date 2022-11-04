import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  bool isLoginEnabled2 = false;

  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  )   : appLoginResult = const FutureResult.empty(),
        user = const User.anonymous();

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.appLoginResult,
    required this.user,
  });
  final FutureResult<Either<LogInFailure, User>> appLoginResult;
  final User user;

  LoginPresentationModel copyWith({
    FutureResult<Either<LogInFailure, User>>? appLoginResult,
    User? user,
  }) {
    return LoginPresentationModel._(
      appLoginResult: appLoginResult ?? this.appLoginResult,
      user: user ?? this.user,
    );
  }

  @override
  bool isLoginEnabled = false;
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  late bool isLoginEnabled;
}
