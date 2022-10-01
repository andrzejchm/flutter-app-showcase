import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';

abstract class UserRepository {
  Future<Either<LogInFailure, User>> getUser({required String username, required String password});
}
