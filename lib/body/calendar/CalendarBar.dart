import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/border/VerticalBorder.dart';

class CalendarBar extends StatelessWidget {
  CalendarBar({super.key, required this.recordItem, required this.dateTime});

  RecordItemClass recordItem;
  DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    bool isLight = context.watch<ThemeProvider>().isLight;

    RecordInfoClass? recordInfo = getRecordInfo(
      recordInfoList: recordItem.taskInfo.recordInfoList,
      targetDateTime: dateTime,
    );
    bool isHighlighter = recordInfo?.mark != null && recordInfo?.mark != 'E';
    ColorClass color = getColorClass(recordItem.groupInfo.colorName);
    Color? highlighterColor = isHighlighter
        ? isLight
            ? color.s50
            : color.original
        : null;
    String name = recordItem.taskInfo.name;

    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Container(
          decoration: BoxDecoration(
            color: highlighterColor,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 0,
                child: VerticalBorder(
                  width: 2,
                  right: 3,
                  color: isLight ? color.s200 : color.s300,
                ),
              ),
              Flexible(
                child: CommonText(
                  text: name,
                  overflow: TextOverflow.clip,
                  isBold: !isLight,
                  initFontSize: fontSize - 5,
                  softWrap: false,
                  textAlign: TextAlign.start,
                  isNotTr: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
