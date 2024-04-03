import 'package:calc_x/theme/layout/extention.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final dynamic coloration, textColor;
  final String buttonText;
  final Function buttonTapped;
  final double? fontSize;

  const Button(
      {super.key,
      required this.coloration,
      required this.textColor,
      required this.buttonText,
      required this.buttonTapped,
      this.fontSize});
  @override
  Widget build(BuildContext context) {
    BorderRadius borderRad = BorderRadius.circular(20);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: coloration),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(color: textColor, fontSize: fontSize ?? 27),
        ),
      ),
    ).ripple(buttonTapped, borderRadius: borderRad).p(8);
  }
}
