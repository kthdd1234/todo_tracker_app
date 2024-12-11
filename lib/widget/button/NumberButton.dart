import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';

class NumberButton extends StatelessWidget {
  NumberButton({super.key, required this.text, required this.onPressed});

  String text;
  Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    double fontSize =
        text == '지우기' ? userInfo.fontSize - 1 : userInfo.fontSize + 3;

    Color textColor = isLight ? darkButtonColor : Colors.white;
    Color bgColor = text != ''
        ? isLight
            ? Colors.white
            : darkContainerColor
        : Colors.transparent;

    return GestureDetector(
      onTap: () => onPressed(text),
      child: CircleAvatar(
        radius: 32.5,
        backgroundColor: bgColor,
        child: CommonText(
          text: text == '지우기' ? text.tr() : text,
          initFontSize: fontSize,
          color: textColor,
          isNotTr: true,
        ),
      ),
    );
  }
}
