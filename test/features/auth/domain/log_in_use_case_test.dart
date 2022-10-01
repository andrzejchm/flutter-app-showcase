import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/dependency_injection/app_component.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late LogInUseCase useCase;
  late UserRepository userRepository;

  setUp(() {
    userRepository = Mocks.userRepository;
    useCase = LogInUseCase(Mocks.userStore, userRepository);
  });

  test(
    'when use case executed with success then user is return',
    () async {
      const username = "test";
      const password = "test123";
      // GIVEN
      when(() => userRepository.getUser(username: username, password: password))
          .thenAnswer((_) => successFuture(const User.empty()));
      // WHEN
      final result = await useCase.execute(username: username, password: password);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test(
    'when use case executed with failure then failure type is unknown',
    () async {
      const username = "wrongname";
      const password = "wrong password";
      // GIVEN
      when(() => userRepository.getUser(username: username, password: password))
          .thenAnswer((_) => failFuture(const LogInFailure.unknown()));
      // WHEN
      final result = await useCase.execute(username: username, password: password);

      // THEN
      expect(result.isFailure, true);
      expect((result.getFailure()!).type, LogInFailureType.unknown);
    },
  );

  test(
    'when use case executed with wrong password or username then failure type is a missing credentials',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(username: "", password: "wrong password");

      // THEN
      expect(result.isFailure, true);
      expect((result.getFailure()!).type, LogInFailureType.missingCredentials);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<LogInUseCase>();
    expect(useCase, isNotNull);
  });
}
