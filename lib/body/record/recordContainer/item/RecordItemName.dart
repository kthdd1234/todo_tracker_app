import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';

class RecordItemName extends StatelessWidget {
  RecordItemName(
      {super.key, required this.name, required this.color, this.mark});

  String name;
  ColorClass color;
  String? mark;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return Expanded(
      child: Container(
        width: double.infinity,
        padding: mark != null
            ? const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5)
            : const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: mark != null
              ? isLight
                  ? color.s50
                  : color.s400
              : null,
        ),
        child: CommonText(
          text: name,
          overflow: TextOverflow.ellipsis,
          isBold: !isLight,
          initFontSize: fontSize,
          softWrap: false,
          textAlign: TextAlign.start,
          isNotTr: true,
        ),
      ),
    );
  }
}
