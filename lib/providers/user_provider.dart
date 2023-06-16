import 'package:flutter/material.dart';
import 'package:second/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: "",
      email: "",
      username: "",
      password: "",
      address: "",
      token: "",
      type: "",
      cart: []);

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
