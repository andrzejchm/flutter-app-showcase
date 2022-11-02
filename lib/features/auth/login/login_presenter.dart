import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/domain/model/displayable_failure.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this.logInUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase logInUseCase;

  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  Future<void> login() async {
    await await logInUseCase
        .execute(username: _model.username, password: _model.password) //
        .observeStatusChanges(
          (result) => emit(
            _model.copyWith(loginUseCase: result),
          ),
        )
        .asyncFold(
          (fail) => navigator.showError(
            DisplayableFailure(title: 'Ops!', message: 'Wrong Credentials!'),
          ),
          (success) => navigator.showAlert(
            title: 'Hurray!',
            message: 'Successfully LoggedIn!',
          ),
        );
  }

  void usernameChanged({required String user}) {
    _model.usernameChanged(user: user);
  }

  void passwordChanged({required String password}) {
    _model.passwordChanged(password: password);
  }
}
