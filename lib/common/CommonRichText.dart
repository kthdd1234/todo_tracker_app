import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';

class CommonRichText extends StatelessWidget {
  CommonRichText({
    super.key,
    required this.startText,
    required this.targetText,
    required this.targetColor,
  });

  String startText, targetText;
  Color targetColor;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeProvider>().isLight;

    return RichText(
      text: TextSpan(
          // text: startText,
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
                text: startText,
                style: TextStyle(
                  color: isLight ? darkButtonColor : Colors.white,
                )),
            TextSpan(
              text: targetText,
              style: TextStyle(color: targetColor),
            ),
          ]),
    );
  }
}
