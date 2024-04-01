import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

import 'function/methodes.dart';
import 'providers/state_provider.dart';
import 'widget/button.dart';
import 'widget/user_input.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => StateProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Buttons
  static List<String> buttons = [
    "C",
    "DEL",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "×",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "( )",
    "=",
  ];

  String userQuestion = "", answer = "";
  dynamic buttonColoration, buttonTextColor;
  bool ableDot = true;
  bool openParenthesis = true;
  int openedParenthesis = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //header
          UserInput(userQuestion: userQuestion, answer: answer),
          //grid of buttons
          Expanded(
            //flex: 2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: buttons.length,
              itemBuilder: (BuildContext context, int index) {
                String currentButton = buttons[index];

                //Clear button conditions
                if (currentButton == "C") {
                  buttonColoration = Colors.white10;
                  buttonTextColor = Colors.red;
                  return Button(
                    coloration: buttonColoration,
                    textColor: buttonTextColor,
                    buttonText: currentButton,
                    buttonTapped: () {
                      openParenthesis = true; // allows parenthesis
                      openedParenthesis = 0;
                      setState(() {
                        userQuestion = "";
                        answer = "";
                        ableDot = true;
                      });
                    },
                  );
                }

                //Delete button conditions
                else if (currentButton == "DEL") {
                  buttonColoration = Colors.red;
                  buttonTextColor = Colors.white;
                  return Button(
                    coloration: buttonColoration,
                    textColor: buttonTextColor,
                    buttonText: currentButton,
                    buttonTapped: () {
                      setState(() {
                        if (userQuestion.isNotEmpty &&
                            userQuestion[userQuestion.length - 1] == '(') {
                          openParenthesis = true; // allows parenthesis
                          openedParenthesis--;
                          debugPrint(" parenthesis $openParenthesis");
                          debugPrint(" openedParenthesis $openedParenthesis");
                        } else if (userQuestion.isNotEmpty &&
                            userQuestion[userQuestion.length - 1] == ')') {
                          openParenthesis = true; // allows parenthesis
                          openedParenthesis++;
                          debugPrint(" parenthesis $openParenthesis");
                          debugPrint(" openedParenthesis $openedParenthesis");
                        }
                        if (userQuestion.isNotEmpty &&
                            userQuestion[userQuestion.length - 1] == ".") {
                          ableDot = true;
                        }
                        //checking each previous term
                        if (userQuestion.isNotEmpty &&
                            isOperator(userQuestion[userQuestion.length - 1])) {
                          for (int index = userQuestion.length - 2;
                              userQuestion.isNotEmpty &&
                                  index > 0 &&
                                  userQuestion[index] != '.' &&
                                  !isOperator(userQuestion[index]);
                              index--) {
                            if (userQuestion[index - 1] == ".") {
                              ableDot = false;
                            } else if (isOperator(userQuestion[index - 1])) {
                              ableDot = true;
                            }
                            debugPrint(
                                userQuestion[index]); // print each element
                          }
                        }
                        if (userQuestion.isNotEmpty) {
                          debugPrint(
                              "deleted at index ${userQuestion.length - 1} value ${userQuestion[userQuestion.length - 1]} "); //print deleted
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                          answer = "";

                          //returns answer if last element is not an operator or a  parenthesis
                          if (userQuestion
                                  .split('')
                                  .any((element) => isOperator(element)) &&
                              !isOperator(
                                  userQuestion[userQuestion.length - 1]) &&
                              userQuestion[userQuestion.length - 1] != '.' &&
                              userQuestion[userQuestion.length - 1] != '(' &&
                              userQuestion[userQuestion.length - 1] != ')' &&
                              !openParenthesis &&
                              openedParenthesis == 0) {
                            userQuestion = userQuestion.replaceAll("×", "*");
                            userQuestion = userQuestion.replaceAll("÷", "/");

                            Parser p = Parser();

                            //error : must check any opened parenthesis (done)
                            Expression exp = p.parse(userQuestion);
                            ContextModel cm = ContextModel();
                            double eval = exp.evaluate(EvaluationType.REAL, cm);
                            final String finalAnswer = eval.toString();

                            if (finalAnswer.endsWith(".0")) {
                              answer = finalAnswer.substring(
                                  0, finalAnswer.length - 2);
                              debugPrint("whole number");
                            } else {
                              answer = finalAnswer;
                              debugPrint("decimal number");
                            }
                            userQuestion = userQuestion.replaceAll("*", "×");
                            userQuestion = userQuestion.replaceAll("/", "÷");
                          }
                        }
                      });
                    },
                  );
                }

                //Equal button conditions
                else if (index == buttons.length - 1) {
                  buttonColoration = Colors.pink[100];
                  buttonTextColor = Colors.black;

                  return Button(
                    fontSize: 34,
                    coloration: buttonColoration,
                    textColor: buttonTextColor,
                    buttonText: currentButton,
                    buttonTapped: () {
                      if (userQuestion.isNotEmpty &&
                          !isOperator(userQuestion[userQuestion.length - 1])) {
                        //if it ends with {"operator" + "dot"}
                        if (userQuestion[userQuestion.length - 1] == '.') {
                          if (userQuestion.length == 1 ||
                              isOperator(
                                  userQuestion[userQuestion.length - 2])) {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                            userQuestion += "0"; // returns "operator" + "0"
                          }
                        }

                        openParenthesis = true; // allows parenthesis
                        openedParenthesis = 0;

                        userQuestion = userQuestion.replaceAll("×", "*");
                        userQuestion = userQuestion.replaceAll("÷", "/");
                        Parser p = Parser();
                        Expression exp = p.parse(userQuestion);
                        ContextModel cm = ContextModel();
                        double eval = exp.evaluate(EvaluationType.REAL, cm);
                        final String finalAnswer = eval.toString();

                        if (finalAnswer.endsWith(".0")) {
                          answer =
                              finalAnswer.substring(0, finalAnswer.length - 2);
                          debugPrint("whole number");
                        } else {
                          answer = finalAnswer;
                          debugPrint("decimal number");
                        }

                        setState(() {
                          userQuestion = answer;
                          if (answer.contains(".")) {
                            ableDot = false;
                            debugPrint(answer);
                          } else {
                            ableDot = true;
                          }
                          answer = "";
                        });
                      }
                    },
                  );
                }

                //dot button
                else if (index == buttons.length - 3) {
                  buttonColoration = Colors.white10;
                  buttonTextColor = Colors.pink[100];
                  return Button(
                      coloration: buttonColoration,
                      textColor: buttonTextColor,
                      buttonText: currentButton,
                      buttonTapped: () {
                        if (ableDot) {
                          setState(() {
                            userQuestion += currentButton;
                          });
                          ableDot = false;
                        }
                      });
                }

                //parentheses button conditions
                else if (index == buttons.length - 2) {
                  buttonColoration = Colors.white10;
                  buttonTextColor = Colors.amber;
                  return Button(
                    coloration: buttonColoration,
                    textColor: buttonTextColor,
                    buttonText: currentButton,
                    buttonTapped: () {
                      if (currentButton == "( )") {
                        if (userQuestion.isNotEmpty &&
                            isANumber(userQuestion[userQuestion.length - 1]) &&
                            openedParenthesis == 0) {
                          setState(() {
                            userQuestion += '×(';
                            openParenthesis = true;

                            openedParenthesis++;
                            debugPrint(" parenthesis $openParenthesis");
                            debugPrint(" openedParenthesis $openedParenthesis");
                          });
                        } else if (userQuestion.isNotEmpty &&
                            userQuestion[userQuestion.length - 1] == "(") {
                          setState(() {
                            userQuestion += '(';
                            openParenthesis = true;
                            openedParenthesis++;
                            debugPrint(" parenthesis $openParenthesis");
                            debugPrint(" openedParenthesis $openedParenthesis");
                          });
                        } else if (userQuestion.isNotEmpty &&
                            isOperator(userQuestion[userQuestion.length - 1])) {
                          setState(() {
                            userQuestion += '(';
                            openParenthesis = true;

                            openedParenthesis++;
                            debugPrint(" parenthesis $openParenthesis");
                            debugPrint(" openedParenthesis $openedParenthesis");
                          });
                        } else if (userQuestion.isEmpty && openParenthesis) {
                          setState(() {
                            userQuestion += '(';
                            openParenthesis = true;

                            openedParenthesis++;
                            debugPrint(" parenthesis $openParenthesis");
                            debugPrint(" openedParenthesis $openedParenthesis");
                          });
                        } else if (!openParenthesis && openedParenthesis != 0) {
                          setState(() {
                            userQuestion += ')';
                            openParenthesis = true;

                            openedParenthesis--;
                            debugPrint(" parenthesis $openParenthesis");
                            debugPrint(" openedParenthesis $openedParenthesis");
                          });
                        } else if (userQuestion[userQuestion.length - 1] ==
                                ")" &&
                            openParenthesis == true &&
                            openedParenthesis != 0) {
                          setState(() {
                            userQuestion += ')';
                            openParenthesis = true;

                            openedParenthesis--;
                            debugPrint(" parenthesis $openParenthesis");
                            debugPrint(" openedParenthesis $openedParenthesis");
                          });
                        } else if (userQuestion[userQuestion.length - 1] ==
                                ")" &&
                            openParenthesis == true &&
                            openedParenthesis == 0) {
                          setState(() {
                            userQuestion += '×(';
                            openParenthesis = true;

                            openedParenthesis++;
                            debugPrint(" parenthesis $openParenthesis");
                            debugPrint(" openedParenthesis $openedParenthesis");
                          });
                        }
                      }
                    },
                  );
                }

                //other buttons
                else {
                  isOperator(currentButton)
                      ? {
                          buttonColoration = Colors.white10,
                          buttonTextColor = Colors.amber,
                        }
                      : {
                          buttonColoration = Colors.white12,
                          buttonTextColor = Colors.white
                        };

                  return Button(
                    coloration: buttonColoration,
                    textColor: buttonTextColor,
                    buttonText: currentButton,
                    buttonTapped: () {
                      //  numbers conditions
                      if (!isOperator(currentButton)) {
                        setState(() {
                          userQuestion += currentButton;
                          openParenthesis = false;
                          print("$openParenthesis");

                          if (
                              //if userQuestion contains an operator
                              userQuestion
                                      .split('')
                                      .any((element) => isOperator(element)) &&
                                  userQuestion[userQuestion.length - 1] !=
                                      '.' &&
                                  openedParenthesis == 0) {
                            // equals method

                            userQuestion = userQuestion.replaceAll("×", "*");
                            userQuestion = userQuestion.replaceAll("÷", "/");

                            Parser p = Parser();
//number after parenthesis x number
//last element ")" run equals method
                            Expression exp = p.parse(userQuestion);
                            ContextModel cm = ContextModel();
                            double eval = exp.evaluate(EvaluationType.REAL, cm);
                            final String finalAnswer = eval.toString();

                            if (finalAnswer.endsWith(".0")) {
                              answer = finalAnswer.substring(
                                  0, finalAnswer.length - 2);
                              debugPrint("whole number");
                            } else {
                              answer = finalAnswer;
                              debugPrint("decimal number");
                            }
                            userQuestion = userQuestion.replaceAll("*", "×");
                            userQuestion = userQuestion.replaceAll("/", "÷");
                          }
                        });
                      }
                      // operators conditions
                      else if (isOperator(currentButton) &&
                          userQuestion.isNotEmpty &&
                          !isOperator(userQuestion[userQuestion.length - 1])) {
                        if (userQuestion[userQuestion.length - 1] != ".") {
                          setState(() {
                            userQuestion += currentButton;
                          });
                        }
                      }
                      //replace the last operator by the new one
                      else if (isOperator(currentButton) &&
                          userQuestion.isNotEmpty &&
                          isOperator(userQuestion[userQuestion.length - 1])) {
                        if (userQuestion.length > 1) {
                          setState(() {
                            //call delete function and add the current button

                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                            userQuestion += currentButton;
                          });
                        }
                      }
                      //  "-" operator
                      if (currentButton == "-" && userQuestion.isEmpty) {
                        setState(() {
                          userQuestion += currentButton;
                        });
                      }
                      //clear onPressing operator
                      if (isOperator(currentButton)) {
                        openParenthesis = true;
                        answer = "";
                        if (userQuestion.isEmpty ||
                            isOperator(userQuestion[userQuestion.length - 1])) {
                          ableDot = true;
                        }
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
