import 'package:mocktail/mocktail.dart';

import 'auth_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class AuthMocks {
  // MVP

  static late MockLoginPresenter loginPresenter;
  static late MockLoginPresentationModel loginPresentationModel;
  static late MockLoginInitialParams loginInitialParams;
  static late MockLoginNavigator loginNavigator;
  //DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockLogInFailure logInFailure;
  static late MockLogInUseCase logInUseCase;
  //DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  //DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD

  // STORES

  //DO-NOT-REMOVE STORES_MOCKS_STATIC_FIELD

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    // MVP
    loginPresenter = MockLoginPresenter();
    loginPresentationModel = MockLoginPresentationModel();
    loginInitialParams = MockLoginInitialParams();
    loginNavigator = MockLoginNavigator();
    //DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    logInFailure = MockLogInFailure();
    logInUseCase = MockLogInUseCase();
    //DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockLoginPresenter());
    registerFallbackValue(MockLoginPresentationModel());
    registerFallbackValue(MockLoginInitialParams());
    registerFallbackValue(MockLoginNavigator());
    //DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockLogInFailure());
    registerFallbackValue(MockLogInUseCase());
    //DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
