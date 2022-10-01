import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/domain/stores/user_store.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/domain/repositories/user_repository.dart';

class LogInUseCase {
  const LogInUseCase(this._userStore, this._userRepository);

  final UserStore _userStore;
  final UserRepository _userRepository;

  Future<Either<LogInFailure, User>> execute({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      return failure(const LogInFailure.missingCredentials());
    }

    final result = await _userRepository.getUser(username: username, password: password);
    if (result.isSuccess) {
      _userStore.user = result.getSuccess()!;
    }

    return result;
  }
}
