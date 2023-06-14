// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  final Color? color;
  final String text;
  final TextStyle textStyle;
  int maxLines;
  TextOverflow textOverflow;
  LargeText({
    this.textStyle = const TextStyle(
      fontFamily: "Inter",
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    this.maxLines = 2,
    super.key,
    this.textOverflow = TextOverflow.ellipsis,
    this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: textOverflow,
      // style: const TextStyle(
      //   fontFamily: "Inter",
      //   color: Colors.black,
      //   fontSize: 17,
      //   fontWeight: FontWeight.bold,
      // ),
      style: textStyle,
    );
  }
}
