import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.loginNavigator,
    this.logInUseCase,
  );

  final LoginNavigator loginNavigator;

  final LogInUseCase logInUseCase;

  LoginPresentationModel get _model => state as LoginPresentationModel;

  void onUsernameChanged({required String username}) {
    emit(_model.copyWith(username: username));
  }

  void onPasswordChanged({required String password}) {
    emit(_model.copyWith(password: password));
  }

  Future<void> requestLogin() async {
    await await logInUseCase
        .execute(username: _model.username, password: _model.password)
        .observeStatusChanges((result) {
      emit(_model.copyWith(loginResult: result));
    }).asyncFold(
      (fail) => loginNavigator.showError(fail.displayableFailure()),
      (User user) => loginNavigator.showAlert(
        title: appLocalizations.loginSuccessTitle,
        message: appLocalizations.loginSuccessMessage,
      ),
    );
  }
}
