import 'dart:convert';
import 'package:faso_vote_client/app/data/models/phone.dart';
import 'package:faso_vote_client/app/utils/helpers/storage_helper.dart';

class User {
  final int id;
  final String? username;
  final String? firstname;
  final String? lastname;
  final bool? hasSecret;
  final List<Phone>? phones;
  User({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.hasSecret,
    required this.phones,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      hasSecret: json['has_secret'],
      phones: (json['phones'] as List<dynamic>?)
              ?.map((phone) => Phone.fromJson(phone))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'has_secret': hasSecret,
      'phones': phones?.map((phone) => phone.toJson()).toList(),
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? firstname,
    String? lastname,
    bool? hasSecret,
    List<Phone>? phones,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      hasSecret: hasSecret ?? this.hasSecret,
      phones: phones ?? this.phones,
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
