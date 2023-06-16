import 'dart:convert';

class Admin {
  final String id;
  final String username;
  final String email;
  final String password;
  final String address;
  final String token;
  final String type;

  Admin({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.address,
    required this.token,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "password": password,
      "address": address,
      "type": type,
      "token": token,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map["_id"] ?? "",
      email: map["email"] ?? "",
      username: map["username"] ?? "",
      password: map["password"] ?? "",
      address: map["address"] ?? "",
      type: map["type"] ?? "",
      token: map["token"] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Admin.fromJson(String source) => Admin.fromMap(json.decode(source));
}
