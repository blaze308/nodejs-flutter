import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String address;
  final String token;
  final String type;
  final List<dynamic> cart;

  User(
      {required this.id,
      required this.email,
      required this.username,
      required this.password,
      required this.address,
      required this.token,
      required this.type,
      required this.cart});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "password": password,
      "address": address,
      "type": type,
      "token": token,
      "cart": cart
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["_id"] ?? "",
      email: map["email"] ?? "",
      username: map["username"] ?? "",
      password: map["password"] ?? "",
      address: map["address"] ?? "",
      type: map["type"] ?? "",
      token: map["token"] ?? "",
      cart: List<Map<String, dynamic>>.from(
          map["cart"]?.map((x) => Map<String, dynamic>.from(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? email,
    String? username,
    String? password,
    String? address,
    String? token,
    String? type,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      address: address ?? this.address,
      token: token ?? this.token,
      type: type ?? this.type,
      cart: cart ?? this.cart,
    );
  }
}
