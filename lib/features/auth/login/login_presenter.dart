import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';

class LoginPresenter extends Cubit<LoginViewModel> with CubitToCubitCommunicationMixin<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this.logInUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase logInUseCase;

  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  Future<void> setFieldsStatus(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      emit(_model.copyWith(loginEnabled: false));
    } else {
      emit(_model.copyWith(loginEnabled: true));
    }
  }

  Future<void> onLogin(String username, String password) async {
    await logInUseCase.execute(username: username, password: password).observeStatusChanges((result) {
      emit(_model.copyWith(logInResult: result));
      processStatusChanges(result);
    }).asyncFold(
      (fail) => () {
        navigator.showError(fail.displayableFailure());
      },
      (success) => () {
        navigator.showAlert(title: 'Login', message: 'Success');
      },
    );
  }

  void processStatusChanges(FutureResult<Either<LogInFailure, User>> result) {
    if (result.result != null) {
      if (result.result!.isSuccess) {
        navigator.showAlert(title: 'Login', message: 'Success');
      } else if (result.result!.isFailure) {
        navigator.showError(result.result!.getFailure()!.displayableFailure());
      }
    }
  }
}
