import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/final.dart';

class DateTimeAlertInfo extends StatelessWidget {
  DateTimeAlertInfo({super.key, required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.info_outline,
          size: fontSize - 4,
          color: isLight ? grey.s400 : Colors.white,
        ),
        CommonSpace(width: 5),
        CommonText(
          text: text,
          color: isLight ? grey.original : Colors.white,
          initFontSize: fontSize - 4,
        ),
      ],
    );
  }
}
