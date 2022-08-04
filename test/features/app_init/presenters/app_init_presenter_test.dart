import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/app_init_failure.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/features/app_init/app_init_initial_params.dart';
import 'package:flutter_demo/features/app_init/app_init_presentation_model.dart';
import 'package:flutter_demo/features/app_init/app_init_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/app_init_mock_definitions.dart';
import '../mocks/app_init_mocks.dart';

void main() {
  late AppInitPresentationModel model;
  late AppInitPresenter presenter;
  late MockAppInitNavigator navigator;

  test(
    'should call appInitUseCase on start',
    () async {
      // GIVEN
      whenListen(
        Mocks.userStore,
        Stream.fromIterable([const User.anonymous()]),
      );
      when(() => AppInitMocks.appInitUseCase.execute()).thenAnswer((_) => successFuture(unit));

      // WHEN
      await presenter.onInit();

      // THEN
      verify(() => AppInitMocks.appInitUseCase.execute());
      verify(() => Mocks.userStore.stream);
    },
  );
  test(
    'should show error when appInitUseCase fails',
    () async {
      // GIVEN
      whenListen(
        Mocks.userStore,
        Stream.fromIterable([const User.anonymous()]),
      );
      when(() => AppInitMocks.appInitUseCase.execute()).thenAnswer((_) => failFuture(const AppInitFailure.unknown()));
      when(() => navigator.showError(any())).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onInit();

      // THEN
      verify(() => navigator.showError(any()));
    },
  );

  setUp(() {
    model = AppInitPresentationModel.initial(const AppInitInitialParams());
    navigator = AppInitMocks.appInitNavigator;
    presenter = AppInitPresenter(
      model,
      navigator,
      AppInitMocks.appInitUseCase,
      Mocks.userStore,
    );
  });
}
