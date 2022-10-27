import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/auth_mock_definitions.dart';

void main() {
  late LoginPresentationModel model;
  late LoginPresenter presenter;
  late LogInUseCase loginUseCase;
  late LoginNavigator loginNavigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = LoginPresentationModel.initial(const LoginInitialParams());
    loginUseCase = MockLogInUseCase();
    loginNavigator = MockLoginNavigator();

    presenter = LoginPresenter(
      model,
      loginUseCase,
      loginNavigator,
    );
  });
}
