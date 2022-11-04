import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/domain/model/displayable_failure.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/navigation/alert_dialog_route.dart';
import 'package:flutter_demo/navigation/error_dialog_route.dart';

class LoginPresenter extends Cubit<LoginViewModel>
    with AlertDialogRoute, ErrorDialogRoute {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this.logInUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase logInUseCase;

  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  Future<void> login(
    String username,
    String password,
  ) async {
    print('start log in use case');
    await await logInUseCase
        .execute(username: username, password: password) //
        .observeStatusChanges(
          (result) => emit(_model.copyWith(appLoginResult: result)),
        )
        .asyncFold(
      (fail) {
        showError(fail.displayableFailure());
        print('error no entering text');
      },
      (success) => showAlert(
        title: 'success',
        message: 'well done',
      ), //todo!
    );
  }
}
