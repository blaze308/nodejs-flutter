// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  final Color? color;
  final String text;
  int maxLines;
  TextStyle textStyle;

  MediumText({
    this.textStyle = const TextStyle(
        fontFamily: "Inter",
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500),
    this.maxLines = 2,
    super.key,
    this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: textStyle,
    );
  }
}
