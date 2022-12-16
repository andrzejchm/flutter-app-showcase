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

  test(
    'should show error when logInUseCase fails',
    () async {
      // GIVEN
      when(() => AuthMocks.logInUseCase.execute(username: any(named: 'username'), password: any(named: 'password')))
          .thenAnswer((_) => failFuture(const LogInFailure.unknown()));
      when(() => navigator.showError(any())).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.login();

      // THEN
      verify(() => navigator.showError(any()));
    },
  );

  test(
    'should show alert when logInUseCase succeeds',
    () async {
      // GIVEN
      final alertTitle = appLocalizations.commonSuccessTitle;
      final alertMessage = appLocalizations.logInSuccessMessage;

      when(() => AuthMocks.logInUseCase.execute(username: any(named: 'username'), password: any(named: 'password')))
          .thenAnswer((_) => successFuture(const User.empty()));
      when(() => navigator.showAlert(title: alertTitle, message: alertMessage)).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.login();

      // THEN
      verify(
        () => navigator.showAlert(title: alertTitle, message: alertMessage),
      );
    },
  );

  test(
    'should fields be empty on start',
    () async {
      // GIVEN

      // WHEN

      // THEN
      expect(model.username, '');
      expect(model.password, '');
    },
  );

  test(
    'should disable login when username and password not filled',
    () async {
      // GIVEN
      const sampleUsername = '';
      const samplePassword = '';

      // WHEN
      presenter.setUsername(sampleUsername);
      presenter.setPassword(samplePassword);

      // THEN
      expect(presenter.state.isLoginEnabled, false);
    },
  );

  test(
    'should enable login when username and password are filled',
    () async {
      // GIVEN
      const sampleUsername = 'test';
      const samplePassword = 't';

      // WHEN
      presenter.setUsername(sampleUsername);
      presenter.setPassword(samplePassword);

      // THEN
      expect(presenter.state.isLoginEnabled, true);
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
