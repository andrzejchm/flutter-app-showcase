import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_demo/core/domain/model/app_init_failure.dart';
import 'package:flutter_demo/core/domain/use_cases/app_init_use_case.dart';
import 'package:flutter_demo/features/app_init/app_init_initial_params.dart';
import 'package:flutter_demo/features/app_init/app_init_navigator.dart';
import 'package:flutter_demo/features/app_init/app_init_presentation_model.dart';
import 'package:flutter_demo/features/app_init/app_init_presenter.dart';
import 'package:mocktail/mocktail.dart';
//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockAppInitPresenter extends MockCubit<AppInitViewModel> implements AppInitPresenter {}

class MockAppInitPresentationModel extends Mock implements AppInitPresentationModel {}

class MockAppInitInitialParams extends Mock implements AppInitInitialParams {}

class MockAppInitNavigator extends Mock implements AppInitNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockAppInitFailure extends Mock implements AppInitFailure {}

class MockAppInitUseCase extends Mock implements AppInitUseCase {}
//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
