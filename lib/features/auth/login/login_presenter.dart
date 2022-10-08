import 'dart:async';

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
    this.logInUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase logInUseCase;
  LoginPresentationModel get _model => state as LoginPresentationModel;

  Future<void> login() async {
    await logInUseCase
        .execute(username: _model.username, password: _model.password)
        .observeStatusChanges((result) => emit(_model.copyWith(loginResult: result)))
        .asyncFold(
          (fail) => navigator.showError(fail.displayableFailure()),
          (success) => unawaited(
            navigator.showAlert(
              title: appLocalizations.success,
              message: appLocalizations.welcome(success.username),
            ),
          ),
        );
  }

  set username(String username) {
    emit(_model.copyWith(username: username));
  }

  set password(String password) {
    emit(_model.copyWith(password: password));
  }
}
