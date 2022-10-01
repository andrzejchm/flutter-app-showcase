import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/domain/stores/user_store.dart';
import 'package:flutter_demo/core/utils/current_time_provider.dart';
import 'package:flutter_demo/core/utils/debouncer.dart';
import 'package:flutter_demo/core/utils/periodic_task_executor.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/domain/repositories/user_repository.dart';
//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

import 'package:flutter_demo/navigation/app_navigator.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockAppNavigator extends Mock implements AppNavigator {}

// MVP

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION
class MockUserRepository extends MockCubit<Either<LogInFailure, User>> implements UserRepository {}

// STORES
class MockUserStore extends MockCubit<User> implements UserStore {}
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

class MockDebouncer extends Mock implements Debouncer {}

class MockPeriodicTaskExecutor extends Mock implements PeriodicTaskExecutor {}

class MockCurrentTimeProvider extends Mock implements CurrentTimeProvider {}

class MockClient extends Mock implements Client {}
