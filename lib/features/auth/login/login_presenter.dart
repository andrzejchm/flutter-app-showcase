import 'package:bloc/bloc.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this.loginUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase loginUseCase;

  LoginPresentationModel get _model => state as LoginPresentationModel;

  void handleUpdateUserName(String value) {
    emit(
      _model.copyWith(userName: value),
    );
  }

  void handleUpdatePassword(String value) {
    emit(
      _model.copyWith(password: value),
    );
  }

  Future<void> handleLogin() async {
    emit(
      _model.copyWith(isLoading: true),
    );
    final response = await loginUseCase.execute(
      username: _model.userName,
      password: _model.password,
    );
    response.fold(
      (fail) => {
        navigator.showError(
          fail.displayableFailure(),
        ),
      },
      (user) => {
        navigator.showAlert(
          title: appLocalizations.logInSuccess,
          message: '${appLocalizations.welcomeLoginMsg} ${user.username}',
        ),
      },
    );
    emit(
      _model.copyWith(isLoading: false),
    );
  }
}
