import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/auth_mock_definitions.dart';
import '../mocks/auth_mocks.dart';

void main() {
  late LoginPresentationModel model;
  late LoginPresenter presenter;
  late MockLoginNavigator navigator;

  test(
    'should disable the login button when no username is provided',
    () {
      // WHEN
      presenter.onUsernameChanged('username');

      // THEN
      expect(presenter.state.isLoginButtonEnabled, false);
    },
  );

  test(
    'should disable the login button when no password is provided',
    () {
      // WHEN
      presenter.onPasswordChanged('password');

      // THEN
      expect(presenter.state.isLoginButtonEnabled, false);
    },
  );

  test(
    'should enable the login button when username and password are provided',
    () {
      // WHEN
      presenter.onUsernameChanged('username');
      presenter.onPasswordChanged('password');

      // THEN
      expect(presenter.state.isLoginButtonEnabled, true);
    },
  );

  test(
    'should show error when logInUseCase fails',
    () async {
      // GIVEN
      when(
        () => AuthMocks.logInUseCase.execute(
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) => failFuture(const LogInFailure.unknown()));
      when(() => navigator.showError(any())).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onLogin();

      // THEN
      verify(() => navigator.showError(any())).called(1);
    },
  );

  test(
    'should show welcome dialog when logInUseCase logged in success',
    () async {
      // GIVEN
      const user = User(
        id: 'id',
        username: 'username',
      );
      when(
        () => AuthMocks.logInUseCase.execute(
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) => successFuture(user));
      when(
        () => navigator.showAlert(
          title: any(named: 'title'),
          message: any(named: 'message'),
        ),
      ).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onLogin();

      // THEN
      verify(
        () => navigator.showAlert(
          title: any(named: 'title'),
          message: any(named: 'message'),
        ),
      ).called(1);
    },
  );

  setUp(() {
    model = LoginPresentationModel.initial(const LoginInitialParams());
    navigator = MockLoginNavigator();
    presenter = LoginPresenter(
      model,
      navigator,
      AuthMocks.logInUseCase,
    );
  });
}
