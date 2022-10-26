import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
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
  late MockLogInUseCase logInUseCase;

  // blocTest<LoginPresenter, LoginViewModel>(
  //   'Verify that state with updated model is emitted when username was changed',
  //   build: () => presenter,
  //   act: (cubit) async {
  //     cubit.onUsernameChanged('newUsername');
  //   },
  //   expect: () => [
  //
  //     model.copyWith(username: 'newUsername'),
  //   ],
  // );
  //
  // blocTest<LoginPresenter, LoginViewModel>(
  //   'Verify that state with updated model is emitted when password was changed',
  //   build: () => presenter,
  //   act: (cubit) async {
  //     cubit.onPasswordChanged('newPassword');
  //   },
  //   expect: () => [
  //     model.copyWith(password: 'newPassword'),
  //   ],
  // );

  test(
    'should show error when logInUseCase fails with credentials error onLoginButtonClicked',
    () async {
      // GIVEN
      when(
        () => AuthMocks.logInUseCase.execute(
          username: 'test',
          password: 'test124',
        ),
      ).thenAnswer((_) => failFuture(const LogInFailure.missingCredentials()));
      when(() => navigator.showError(any())).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onLoginButtonClicked(
        username: 'test',
        password: 'test124',
      );

      // THEN
      verify(() => navigator.showError(any()));
    },
  );

  test(
    'should show error when logInUseCase fails with unknown error onLoginButtonClicked',
    () async {
      // GIVEN
      when(
        () => AuthMocks.logInUseCase.execute(
          username: 'test',
          password: 'test123',
        ),
      ).thenAnswer((_) => failFuture(const LogInFailure.unknown()));
      when(() => navigator.showError(any())).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onLoginButtonClicked(
        username: 'test',
        password: 'test123',
      );

      // THEN
      verify(() => navigator.showError(any()));
    },
  );

  test(
    'should show alert when logInUseCase succeeds onLoginButtonClicked',
    () async {
      // GIVEN
      when(
        () => AuthMocks.logInUseCase.execute(
          username: 'test',
          password: 'test123',
        ),
      ).thenAnswer(
        (_) => successFuture(const User(id: 'id', username: 'test')),
      );

      when(
        () => navigator.showAlert(
          title: appLocalizations.loginSuccessTitle,
          message: appLocalizations.loginSuccessMessage,
        ),
      ).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onLoginButtonClicked(
        username: 'test',
        password: 'test123',
      );

      // THEN
      verify(
        () => navigator.showAlert(
          title: appLocalizations.loginSuccessTitle,
          message: appLocalizations.loginSuccessMessage,
        ),
      );
    },
  );

  setUp(() {
    model = const LoginPresentationModel.initial(LoginInitialParams());
    navigator = MockLoginNavigator();
    logInUseCase = AuthMocks.logInUseCase;

    presenter = LoginPresenter(
      model,
      navigator,
      logInUseCase,
    );
  });
}
