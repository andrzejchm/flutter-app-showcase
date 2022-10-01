import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/auth_mock_definitions.dart';
import '../mocks/auth_mocks.dart';

void main() {
  late LoginPresentationModel model;
  late LoginPresenter presenter;
  late MockLoginNavigator navigator;
  late LogInUseCase logInUseCase;

  test(
    'when password and username arent provided then button is enabled',
    () {
      model.copyWith(userName: "", password: "");

      expect(model.isLoginEnabled, false);
    },
  );

  test(
    'when password and username are wrong then error dialog is showing',
    () async {
      const username = "username";
      const password = "password";

      when(() => navigator.showError(any())).thenAnswer((invocation) => Future.value());
      when(() => logInUseCase.execute(username: model.userNameValue, password: model.userNameValue))
          .thenAnswer((invocation) async => failFuture(const LogInFailure.unknown()));

      model.copyWith(userName: username, password: password);

      await presenter.login();

      verify(() => logInUseCase.execute(username: model.userNameValue, password: model.passwordValue));
      verify(() => navigator.showError(any()));
    },
  );

  test(
    'when password and username are correctly then is message dialog is showing',
    () async {
      const username = "test";
      const password = "password";

      model.copyWith(userName: username, password: password);

      when(
        () => navigator.showAlert(
          title: appLocalizations.loginSuccessTitle,
          message: appLocalizations.loginSuccessMessage(model.userNameValue),
        ),
      ).thenAnswer((invocation) async => Future.value());
      when(
        () => logInUseCase.execute(username: model.userNameValue, password: model.passwordValue),
      ).thenAnswer((invocation) async => successFuture(const User.anonymous()));

      await presenter.login();

      verify(() => logInUseCase.execute(username: model.userNameValue, password: model.passwordValue));
      verify(
        () => navigator.showAlert(
          message: appLocalizations.loginSuccessMessage(model.userNameValue),
          title: appLocalizations.loginSuccessTitle,
        ),
      );
    },
  );

  setUp(() {
    logInUseCase = AuthMocks.logInUseCase;
    model = LoginPresentationModel.initial(const LoginInitialParams());
    navigator = MockLoginNavigator();
    presenter = LoginPresenter(model, navigator, logInUseCase);
  });
}
