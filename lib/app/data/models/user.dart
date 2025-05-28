import 'dart:convert';
import 'package:faso_vote_client/app/utils/helpers/storage_helper.dart';

class User {
  final int id;
  final String? username;
  final String? email;


  User({
    required this.id,
    required this.username,
    required this.email,
 
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['name'],
       email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  static void saveUser(User user) {
    String userJson = jsonEncode(user.toJson());
    StorageHelper.set('user', userJson);
  }

  static User? getUser() {
    String? userJson = StorageHelper.get('user');
    if (userJson != null && userJson.isNotEmpty) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  static void clearUser() {
    StorageHelper.delete('user');
  }
}
