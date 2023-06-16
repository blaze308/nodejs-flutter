// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second/models/admin.dart';
import 'package:second/pages/add_product.dart';
import 'package:second/providers/admin_provider.dart';
import 'package:second/services/error_handling.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/snackbar.dart';

class AdminAuthService {
  void signupAdmin({
    required BuildContext context,
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      Admin admin = Admin(
        id: "",
        email: email,
        username: username,
        password: password,
        address: "",
        token: "",
        type: "",
      );

      http.Response res = await http.post(
          Uri.parse("http://192.168.100.20:7000/admin/signup"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: admin.toJson());

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, "Admin account created. Login in with same credentials");
        },
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void loginAdmin({
    required BuildContext context,
    required String identifier,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse("http://192.168.100.20:7000/admin/login"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode({
            "identifier": identifier,
            "password": password,
          }));

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<AdminProvider>(context, listen: false)
                .setAdmin(res.body);
            await prefs.setString(
                "adminTokenKey", jsonDecode(res.body)["adminToken"]);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddProduct()));
            showSnackBar(context, "You are now logged in as Admin");
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }
}
