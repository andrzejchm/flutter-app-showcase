import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPresenter extends Cubit<LoginViewModel>  with CubitToCubitCommunicationMixin<LoginViewModel>{
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this.logInUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase logInUseCase;

  LoginPresentationModel get _model => state as LoginPresentationModel;

  void updateUserName(String userName) {
    emit(_model.copyWith(userName: userName));
  }

  void updatePassword(String password) {
    emit(_model.copyWith(password: password));
  }

  Future<void> login() async {
    await logInUseCase
        .execute(username: _model.userNameValue, password: _model.passwordValue)
        .observeStatusChanges((result) => emit(_model.copyWith(isPending: result.isPending())))
        .asyncFold(
          (error) => navigator.showError(error.displayableFailure()),
          (user) => {
            navigator.showAlert(
              title: appLocalizations.loginSuccessTitle,
              message: appLocalizations.loginSuccessMessage(user.username),
            ),
          },
        );
  }
}
