import 'package:flutter/material.dart';

class YureText extends StatelessWidget {
  final Color? fontColor;
  const YureText({super.key, this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      "YURE Connect",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: fontColor ?? Colors.black,
          fontStyle: FontStyle.italic,
          fontSize: 30,
          fontFamily: "Steelfish"),
    );
  }
}
