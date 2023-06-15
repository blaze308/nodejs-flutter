import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:second/models/product.dart';

void addProduct({
  required String title,
  required String category,
  required double price,
  required String desc,
  required File image,
}) async {
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
      price: price);
}
