import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  );

  /// Used for the copyWith method
  LoginPresentationModel._();

  //Implemented LoginViewModel private Values
  bool _signInButtonEnabled = false;
  String _username = '';
  String _password = '';

  @override
  String get password => _password;

  @override
  bool get signInButtonEnabled =>
      _username.trim().isNotEmpty && _password.trim().isNotEmpty;

  @override
  String get username => _username;

  LoginPresentationModel copyWith() {
    return LoginPresentationModel._();
  }

  void signInClicked({required bool value}) {
    _signInButtonEnabled = value;
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
  bool get signInButtonEnabled;
  String get username;
  String get password;
}
