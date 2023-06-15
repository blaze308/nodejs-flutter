import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second/widgets/app_bar.dart';
import 'package:second/widgets/large_text.dart';
import 'package:second/widgets/nav_drawer.dart';
import 'package:second/widgets/snackbar.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final picker = ImagePicker();
  File? imageFile;

// Function to pick an image from the gallery
  Future<void> pickImageFromGallery() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var imagePath = pickedFile.path;

      setState(() {
        imageFile = File(imagePath);
      });

      print(imageFile.toString());
    } else {
      // User cancelled the image picking
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        drawer: const NavDrawer(),
        body: Container(
            padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
            child: SingleChildScrollView(
              child: Form(
                  child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: LargeText(text: "Add New Product")),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Product Name*")),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(1),
                        fillColor: Colors.white.withOpacity(0.5),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Align(
                        alignment: Alignment.centerLeft, child: Text("Price*")),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(1),
                        fillColor: Colors.white.withOpacity(0.5),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Product tags*")),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(1),
                        fillColor: Colors.white.withOpacity(0.5),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Product description*")),
                  ),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        fillColor: Colors.white.withOpacity(0.5),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(height: 10),
                  imageFile == null
                      ? GestureDetector(
                          onTap: pickImageFromGallery,
                          child: Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.folder_open),
                                Text("select product image")
                              ],
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            imageFile!,
                            width: 200,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 30),
                            backgroundColor: const Color(0xff392FAF)),
                        onPressed: () {},
                        child: const Text("Add New Product")),
                  )
                ],
              )),
            )));
  }
}
