// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:provider/provider.dart';
import 'package:second/models/product.dart';
import 'package:second/providers/user_provider.dart';
import 'package:second/services/error_handling.dart';
import 'package:second/widgets/snackbar.dart';

class AdminServices {
  void addProduct({
    required BuildContext context,
    required String title,
    required String category,
    required double price,
    required String desc,
    required File image,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic("dn1lv5x6e", "uploads");
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, folder: "ecommdb"),
      );
      var imageUrl = res.secureUrl;

      Product product = Product(
        title: title,
        category: category,
        image: imageUrl,
        desc: desc,
        price: price,
      );

      http.Response response = await http.post(
        Uri.parse("http://192.168.100.20:7000/api/admin/addproduct"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "tokenKey": userProvider.user.token
        },
        body: jsonEncode(product.toJson()),
      );

      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Product added");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
