import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonButton.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';

class DateTimeButton extends StatelessWidget {
  DateTimeButton({
    super.key,
    required this.color,
    required this.text,
    required this.type,
    required this.selectedType,
    required this.onTap,
  });

  ColorClass color;
  String text, type, selectedType;
  Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isSelectedType = selectedType == type;

    Color notTextColor = isLight ? grey.original : Colors.white;
    Color notBgColor = isLight ? whiteBgBtnColor : darkNotSelectedBgColor;

    Color textColor = isSelectedType ? Colors.white : notTextColor;
    Color buttonColor = isSelectedType
        ? isLight
            ? color.s200
            : color.s300
        : notBgColor;

    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return Expanded(
      child: CommonButton(
        text: text,
        initFontSize: fontSize - 2,
        isBold: isSelectedType,
        textColor: textColor,
        buttonColor: buttonColor,
        verticalPadding: 10,
        borderRadius: 5,
        onTap: () => onTap(type),
      ),
    );
  }
}
