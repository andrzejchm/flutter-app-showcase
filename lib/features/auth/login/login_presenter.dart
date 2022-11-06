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
    this.logInUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase logInUseCase;

  LoginPresentationModel get _model => state as LoginPresentationModel;

  void usernameChanged(String username) => emit(
        _model.copyWith(username: username),
      );

  void passwordChanged(String password) => emit(
        _model.copyWith(password: password),
      );

  Future<void> logInClicked() => logInUseCase
          .execute(
            username: _model.username,
            password: _model.password,
          )
          .observeStatusChanges(
            (result) => emit(_model.copyWith(logInResult: result)),
          )
          .asyncFold(
        (fail) => navigator.showError(fail.displayableFailure()),
        (success) {
          final displayableSuccess = success.displayableSuccess();

          navigator.showAlert(
            title: displayableSuccess.title,
            message: displayableSuccess.message,
          );
        },
      );
}
