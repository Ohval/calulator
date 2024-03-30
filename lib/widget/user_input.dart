import 'package:flutter/material.dart';

import '../function/methodes.dart';

class UserInput extends StatefulWidget {
  const UserInput(
      {super.key, required this.userQuestion, required this.answer});

  final String userQuestion;
  final String answer;

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 248.3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                  // height: 60,
                  ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    // height: 60,
                    width: double.maxFinite,
                    alignment: Alignment.centerLeft,
                    child: RichText(
                        // input text and operator color
                        text: TextSpan(
                            children: widget.userQuestion.split('').map((e) {
                      Color? inputTextColor;
                      if (isOperator(e)) {
                        inputTextColor = Colors.amber;
                      } else if (isANumber(e)) {
                        inputTextColor = Colors.white;
                      } else if (e == ".") {
                        inputTextColor = Colors.pink[100];
                      }
                      return TextSpan(
                          text: e,
                          style:
                              TextStyle(color: inputTextColor, fontSize: 35));
                    }).toList()))),
              ),
            ),
            Expanded(
              child: Container(
                // height: 60,
                width: double.maxFinite,
                alignment: Alignment.centerRight,
                child: Text(
                  widget.answer,
                  style:
                      const TextStyle(fontSize: 18, color: Colors.amberAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
