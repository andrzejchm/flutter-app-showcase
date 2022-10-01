import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  )   : passwordValue = "",
        userNameValue = "",
        isPending = false;

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.userNameValue,
    required this.passwordValue,
    required this.isPending,
  });

  final bool isPending;

  @override
  final String userNameValue;
  @override
  final String passwordValue;

  @override
  bool get isLoginEnabled => passwordValue.isNotEmpty && userNameValue.isNotEmpty;

  @override
  bool get isLoading => isPending;

  LoginPresentationModel copyWith({
    bool? isPending,
    String? userName,
    String? password,
  }) {
    return LoginPresentationModel._(
      userNameValue: userName ?? userNameValue,
      passwordValue: password ?? passwordValue,
      isPending: isPending ?? this.isPending,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  String get userNameValue;

  String get passwordValue;

  bool get isLoginEnabled;

  bool get isLoading;
}
