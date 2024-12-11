import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/widget/button/NumberButton.dart';

class PasswordNumberPad extends StatelessWidget {
  PasswordNumberPad({super.key, required this.onPressed});

  Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    List<List<String>> numberArrayList = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', '지우기'],
    ];

    return Column(
      children: numberArrayList
          .map(
            (numberArray) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberButton(
                    text: numberArray[0],
                    onPressed: onPressed,
                  ),
                  CommonSpace(width: 20),
                  NumberButton(
                    text: numberArray[1],
                    onPressed: onPressed,
                  ),
                  CommonSpace(width: 20),
                  NumberButton(
                    text: numberArray[2],
                    onPressed: onPressed,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
