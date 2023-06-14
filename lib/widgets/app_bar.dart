import 'package:flutter/material.dart';
import 'large_text.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: LargeText(text: "Awesome Store"),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54, size: 30));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  // Size get preferredSize => throw UnimplementedError();
}
