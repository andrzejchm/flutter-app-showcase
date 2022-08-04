import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/stores/user_store.dart';
import 'package:flutter_demo/dependency_injection/app_component.dart';
import 'package:flutter_demo/features/app_init/app_init_initial_params.dart';
import 'package:flutter_demo/features/app_init/app_init_navigator.dart';
import 'package:flutter_demo/features/app_init/app_init_page.dart';
import 'package:flutter_demo/features/app_init/app_init_presentation_model.dart';
import 'package:flutter_demo/features/app_init/app_init_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/app_init_mock_definitions.dart';
import '../mocks/app_init_mocks.dart';

Future<void> main() async {
  late AppInitPage page;
  late AppInitInitialParams initParams;
  late AppInitPresentationModel model;
  late AppInitPresenter presenter;
  late AppInitNavigator navigator;

  void _initMvp() {
    initParams = const AppInitInitialParams();
    model = AppInitPresentationModel.initial(
      initParams,
    );
    navigator = MockAppInitNavigator();
    presenter = AppInitPresenter(
      model,
      navigator,
      AppInitMocks.appInitUseCase,
      UserStore(),
    );
    page = AppInitPage(presenter: presenter);
  }

  await screenshotTest(
    "app_init_page",
    setUp: () async {
      _initMvp();
      when(() => AppInitMocks.appInitUseCase.execute()).thenAnswer((_) => successFuture(unit));
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<AppInitPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
