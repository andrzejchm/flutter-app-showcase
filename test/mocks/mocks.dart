import 'package:flutter/material.dart';
import 'package:flutter_demo/core/domain/model/displayable_failure.dart';
import 'package:flutter_demo/core/utils/periodic_task_executor.dart';
import 'package:flutter_demo/navigation/app_navigator.dart';
import 'package:mocktail/mocktail.dart';

import '../features/app_init/mocks/app_init_mocks.dart';
import '../features/auth/mocks/auth_mocks.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

import 'mock_definitions.dart';

class Mocks {
  static late MockAppNavigator appNavigator;

  // MVP

  //DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  //DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  //DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD

  // STORES
  static late MockUserStore userStore;

  //DO-NOT-REMOVE STORES_MOCKS_STATIC_FIELD

  static late MockDebouncer debouncer;
  static late MockPeriodicTaskExecutor periodicTaskExecutor;
  static late MockCurrentTimeProvider currentTimeProvider;

  static void init() {
    AppInitMocks.init();
    AuthMocks.init();
//DO-NOT-REMOVE FEATURE_MOCKS_INIT

    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    appNavigator = MockAppNavigator();
    // MVP
    //DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    //DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    userStore = MockUserStore();
    //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    debouncer = MockDebouncer();
    periodicTaskExecutor = MockPeriodicTaskExecutor();
    currentTimeProvider = MockCurrentTimeProvider();
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    registerFallbackValue(DisplayableFailure(title: "", message: ""));
    // MVP
    //DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    //DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    registerFallbackValue(MockUserStore());
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE

    registerFallbackValue(materialRoute(Container()));
    registerFallbackValue(MockDebouncer());
    registerFallbackValue(MockCurrentTimeProvider());
    registerFallbackValue(PeriodicTaskExecutor());
  }
}
