import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this._logInUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase _logInUseCase;

  LoginPresentationModel get _model => state as LoginPresentationModel;

  void changeUsername(String value) => emit(_model.copyWith(username: value));

  void changePassword(String value) => emit(_model.copyWith(password: value));

  void performLogin() {
    _logInUseCase
        .execute(username: _model.username, password: _model.password)
        .observeStatusChanges((result) => emit(_model.copyWith(logInResult: result)))
        .asyncFold(
          (fail) => navigator.showError(fail.displayableFailure()),
          (success) => navigator.showAlert(title: 'Success', message: 'TODO: route somewhere'),
        );
  }
}
