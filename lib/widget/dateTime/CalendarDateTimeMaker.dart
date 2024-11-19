import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';

class CalendarDateTimeMaker extends StatelessWidget {
  CalendarDateTimeMaker({
    super.key,
    required this.day,
    required this.isLight,
    required this.color,
    required this.size,
    this.borderRadius,
  });

  String day;
  bool isLight;
  ColorClass color;
  double size;
  double? borderRadius;

  @override
  Widget build(BuildContext context) {
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isLight ? color.s300 : color.s400,
          borderRadius: BorderRadius.circular(borderRadius ?? 100),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 0, top: 0),
          child: Center(
            child: CommonText(
              initFontSize: fontSize - 2,
              text: day,
              color: isLight ? Colors.white : color.s50,
              isBold: true,
              isNotTr: true,
            ),
          ),
        ),
      ),
    );
  }
}
