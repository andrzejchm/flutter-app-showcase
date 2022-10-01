import 'package:flutter_demo/dependency_injection/app_component.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_page.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late LoginPage page;
  late LoginInitialParams initParams;
  late LoginPresentationModel model;
  late LoginPresenter presenter;
  late LoginNavigator navigator;
  late LogInUseCase useCase;

  void _initMvp() {
    initParams = const LoginInitialParams();
    model = LoginPresentationModel.initial(
      initParams,
    );
    useCase = LogInUseCase(Mocks.userStore, Mocks.userRepository);
    navigator = LoginNavigator(Mocks.appNavigator);
    presenter = LoginPresenter(
      model,
      navigator,
      useCase,
    );
    page = LoginPage(presenter: presenter);
  }

  await screenshotTest(
    "login_page",
    variantName: "when_page_is_initial_state_then_button_is_disabled",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "login_page",
    variantName: "when_user_name_and_password_are_provided_then_button_is_enabled",
    setUp: () async {
      _initMvp();
      presenter.emit(
        model.copyWith(
          userName: "username",
          password: "password",
        ),
      );
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<LoginPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
