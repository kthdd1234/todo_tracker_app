import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';

class RecordItemName extends StatelessWidget {
  RecordItemName({super.key, required this.name});

  String name;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return CommonText(
      text: name,
      overflow: TextOverflow.clip,
      isBold: !isLight,
      initFontSize: fontSize,
      softWrap: false,
      textAlign: TextAlign.start,
      isNotTr: true,
    );
  }
}
