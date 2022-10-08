import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    super.model,
    this.navigator,
    this.loginUseCase,
  );

  final LoginNavigator navigator;
  final LoginUseCase loginUseCase;

  LoginPresentationModel get _model => state as LoginPresentationModel;

  void onUsernameChanged(String text) => emit(_model.copyWith(username: text));

  void onPasswordChanged(String text) => emit(_model.copyWith(password: text));

  Future<void> login() {
    return loginUseCase
        .execute(username: _model.username, password: _model.password)
        .observeStatusChanges(
          (result) => emit(_model.copyWith(result: result)),
        )
        .asyncFold(
          (fail) => navigator.showError(fail.displayableFailure()),
          (success) => navigator.showAlert(
            title: appLocalizations.logInSuccess,
            message: appLocalizations.logInSuccessDescription,
          ),
        );
  }
}
