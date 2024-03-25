// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final dynamic coloration;
  final dynamic textColor;
  final String buttonText;
  final dynamic buttonTapped;
  final double? fontSize;
  const Button(
      {super.key,
      required this.coloration,
      required this.textColor,
      required this.buttonText,
      required this.buttonTapped,
      this.fontSize});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.coloration),
          child: Center(
            child: Text(
              widget.buttonText,
              style: TextStyle(
                  color: widget.textColor, fontSize: widget.fontSize ?? 27),
            ),
          ),
        ),
      ),
    );
  }
}
