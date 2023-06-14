import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:second/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:second/services/error_handling.dart';
import 'package:second/widgets/snackbar.dart';

class AuthService {
  void signupUser({
    required BuildContext context,
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      User user = User(
          id: "",
          email: email,
          username: username,
          password: password,
          address: "",
          token: "",
          type: "");

      http.Response res = await http.post(
          Uri.parse("http://192.168.100.20:7000/api/signup"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: user.toJson());

      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, "Account created. Login in with same credentials");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void loginUser({
    required BuildContext context,
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse("http://192.168.100.20:7000/api/login"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode({
            "email": email,
            "username": username,
            "password": password,
          }));

      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, "Account created. Login in with same credentials");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
