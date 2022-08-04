import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:mocktail/mocktail.dart';
//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockLoginPresenter extends MockCubit<LoginViewModel> implements LoginPresenter {}

class MockLoginPresentationModel extends Mock implements LoginPresentationModel {}

class MockLoginInitialParams extends Mock implements LoginInitialParams {}

class MockLoginNavigator extends Mock implements LoginNavigator {}
//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockLogInFailure extends Mock implements LogInFailure {}

class MockLogInUseCase extends Mock implements LogInUseCase {}
//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
