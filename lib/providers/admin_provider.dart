import 'package:flutter/material.dart';
import 'package:second/models/admin.dart';

class AdminProvider extends ChangeNotifier {
  Admin _admin = Admin(
    id: "",
    email: "",
    username: "",
    password: "",
    address: "",
    token: "",
    type: "",
  );

  Admin get admin => _admin;

  void setAdmin(String admin) {
    _admin = Admin.fromJson(admin);
    notifyListeners();
  }
}
