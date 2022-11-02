import 'package:bloc/bloc.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
  );

  final LoginNavigator navigator;

  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  void usernameChanged({required String user}) {
    _model.usernameChanged(user: user);
  }

  void passwordChanged({required String password}) {
    _model.passwordChanged(password: password);
  }

  void signInClicked({required bool value}) {
    _model.signInClicked(value: value);
  }
}
