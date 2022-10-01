import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/data/rest/model/user_json.dart';
import 'package:flutter_demo/features/auth/data/rest/rest_api_const.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/domain/repositories/user_repository.dart';
import 'package:http/http.dart';

class RestApiUserRepository implements UserRepository {
  RestApiUserRepository(this.client);

  final Client client;

  @override
  Future<Either<LogInFailure, User>> getUser({required String username, required String password}) async {
    final response = await client.get(Uri.parse(RestApiConst.JSON_URL));

    if (response.statusCode == RestApiConst.SUCCESS_RESPONSE_CODE) {
      final userResponse = UserJson.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      return success(userResponse.toUserDomain());
    } else {
      // Parsing error body to Api Exception
      return failure(const LogInFailure.unknown());
    }
  }
}
