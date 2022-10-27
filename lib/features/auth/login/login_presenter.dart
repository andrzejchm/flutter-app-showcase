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
    this.logInUseCase,
    this.loginNavigator,
  );

  final LogInUseCase logInUseCase;
  final LoginNavigator loginNavigator;

  // ignore: unused_element
  String? get username => _model.username;
  String? get password => _model.password;

  LoginPresentationModel get _model => state as LoginPresentationModel;

  void updateUsername(String? value) => emit(
        _model.copyWith(username: value),
      );

  void updatePassword(String? value) => emit(
        _model.copyWith(password: value),
      );

  Future<void> onLogIn() async {
    await logInUseCase
        .execute(username: _model.username, password: _model.password)
        .observeStatusChanges(
          (result) => emit(
            _model.copyWith(result: result),
          ),
        )
        .asyncFold(
          (fail) => loginNavigator.showError(fail.displayableFailure()),
          (success) => {
            loginNavigator.showAlert(
              title: appLocalizations.commonSuccessTitle,
              message: appLocalizations.commonSuccessMessage,
            ),
          },
        );
  }
}
