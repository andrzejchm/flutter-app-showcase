import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/data/rest/rest_api_const.dart';
import 'package:flutter_demo/features/auth/data/rest/rest_api_user_repository.dart';
import 'package:flutter_demo/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/json_responses.dart';

void main() {
  late Client client;
  late UserRepository userRepository;

  setUp(() {
    client = Mocks.client;
    userRepository = RestApiUserRepository(client);
  });

  test('when request executed with success then user is return', () async {
    final response = Response(JsonResponses.USER_BODY_RESPONSE, 200);
    when(() => client.get(Uri.parse(RestApiConst.JSON_URL))).thenAnswer(
      (invocation) => Future.value(
        response,
      ),
    );

    final result = await userRepository.getUser(username: "test", password: "password");

    expect(result.isSuccess, true);
  });

  test('when request executed with failure then failure is return', () async {
    final response = Response("", 404);
    when(() => client.get(Uri.parse(RestApiConst.JSON_URL))).thenAnswer(
      (invocation) => Future.value(
        response,
      ),
    );

    final result = await userRepository.getUser(username: "test", password: "password");

    expect(result.isFailure, true);
  });
}
