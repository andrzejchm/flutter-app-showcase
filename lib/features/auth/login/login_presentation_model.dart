import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  )   : isLoading = initialParams.isLoading,
        userName = initialParams.userName,
        password = initialParams.password;

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.userName,
    required this.password,
    required this.isLoading,
  });

  @override
  final bool isLoading;
  final String userName;
  final String password;

  @override
  bool get isLoginEnabled => userName.isNotEmpty && password.isNotEmpty;

  LoginPresentationModel copyWith({
    String? userName,
    String? password,
    bool? isLoading,
  }) {
    return LoginPresentationModel._(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoading;
  bool get isLoginEnabled;
}
