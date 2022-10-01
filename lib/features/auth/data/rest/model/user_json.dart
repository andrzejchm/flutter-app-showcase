import 'package:flutter_demo/core/domain/model/user.dart';

class UserJson {
  UserJson({required this.id, required this.username});

  factory UserJson.fromJson(Map<String, dynamic> json) => UserJson(
        id: json["id"] as String? ?? '',
        username: json["username"] as String? ?? '',
      );

  final String? id;
  final String? username;

  User toUserDomain() => User(
        id: id ?? "",
        username: username ?? "",
      );
}
