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

  void onUsernameChanged(String username) {
    emit(_model.copyWith(username: username));
  }

  void onPasswordChanged(String password) {
    emit(_model.copyWith(password: password));
  }
}
