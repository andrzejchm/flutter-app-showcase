import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this.useCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase useCase;

  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  void userNameChanged(String userName) {
    emit(_model.copyWith(username: userName));
  }

  void passwordChanged(String password) {
    emit(_model.copyWith(password: password));
  }

  Future<void> logInClicked() async {
    await (await useCase
        .execute(password: _model.password, username: _model.username)
        .observeStatusChanges(
          (result) => emit(_model.copyWith(loginResult: result)),
        )
        .asyncFold(
          (fail) => navigator.showError(fail.displayableFailure()),
          (success) => navigator.showAlert(
            title: '${appLocalizations.logInSuccessTitle}, ${success.username}',
            message: appLocalizations.logInSuccessMessage,
          ),
        ));
  }
}
