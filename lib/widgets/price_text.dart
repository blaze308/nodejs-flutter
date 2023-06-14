// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  Color color;
  final String text;
  TextStyle textStyle;
  PriceText({
    this.textStyle = const TextStyle(
        fontSize: 16,
        fontFamily: "Inter",
        fontWeight: FontWeight.bold,
        color: Color(0xFF869013)),
    super.key,
    this.color = const Color(0xFF869013),
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
