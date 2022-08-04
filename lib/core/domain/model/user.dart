import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.bio,
    required this.profileImageUrl,
    required this.createdAt,
    required this.phone,
    required this.email,
    required this.followers,
    required this.likes,
    required this.views,
  });

  const User.anonymous()
      : id = '',
        username = '',
        bio = '',
        profileImageUrl = '',
        createdAt = '',
        phone = '',
        email = '',
        followers = 0,
        likes = 0,
        views = 0;

  final String id;
  final String username;
  final String bio;
  final String profileImageUrl;
  final String createdAt;
  final String phone;
  final String email;
  final int followers;
  final int likes;
  final int views;

  @override
  List<Object> get props => [
        id,
        username,
        profileImageUrl,
        createdAt,
        phone,
        email,
        followers,
        likes,
        views,
      ];
}
