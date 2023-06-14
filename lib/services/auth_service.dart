import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:second/providers/user_provider.dart';
import 'package:second/services/error_handling.dart';
import 'package:second/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString("tokenKey", jsonDecode(res.body)["token"]);

            // ignore: use_build_context_synchronously
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future fetchData() async {
    try {
      http.Response res = await http.get(
        Uri.parse("http://192.168.100.20:7000/api/data"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      var data = jsonDecode(res.body);
      return data;
      // var result = data.toList();
      // print(data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future fetchCategory(String category) async {
    try {
      http.Response res = await http.get(
        Uri.parse("http://192.168.100.20:7000/api/data/category/$category"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      var data = jsonDecode(res.body);
      print(data);
      return data;
      // var result = data.toList();
      // print(data);
    } catch (e) {
      print(e.toString());
    }
  }
}
