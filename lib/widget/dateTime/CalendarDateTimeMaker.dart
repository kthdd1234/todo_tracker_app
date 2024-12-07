import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';

class CalendarDateTimeMaker extends StatelessWidget {
  CalendarDateTimeMaker({
    super.key,
    required this.day,
    required this.color,
    required this.size,
    this.borderRadius,
    this.mark,
    this.height,
  });

  String day;
  ColorClass color;
  double size;
  double? borderRadius, height;
  String? mark;

  @override
  Widget build(BuildContext context) {
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    bool isLight = context.watch<ThemeProvider>().isLight;

    Color bgColor = isLight ? color.s50 : color.s400;
    Color textColor = isLight ? color.original : color.s50;

    return Column(
      children: [
        CommonSpace(height: height ?? 20),
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 100),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 0, top: 0),
            child: Center(
              child: mark != null
                  ? svgAsset(
                      name: 'mark-$mark',
                      width: fontSize - 2,
                      color: textColor,
                    )
                  : CommonText(
                      initFontSize: fontSize - 2,
                      text: day,
                      color: textColor,
                      isBold: true,
                      isNotTr: true,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
