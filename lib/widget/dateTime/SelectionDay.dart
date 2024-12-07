import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/dateTime/CalendarDateTimeMaker.dart';

class SelectionDay extends StatefulWidget {
  SelectionDay({
    super.key,
    required this.fontSize,
    required this.color,
    required this.focusedDay,
    required this.selectionDays,
    required this.selectedType,
    required this.onSelectionDay,
  });

  double fontSize;
  ColorClass color;
  DateTime focusedDay;
  List<DateTime> selectionDays;
  String selectedType;
  Function(DateTime) onSelectionDay;

  @override
  State<SelectionDay> createState() => _SelectionDayState();
}

class _SelectionDayState extends State<SelectionDay> {
  Widget? markerBuilder(
    String locale,
    DateTime dateTime,
    bool isLight,
  ) {
    if (isContainIdxDateTime(
          locale: locale,
          selectionList: widget.selectionDays,
          targetDateTime: dateTime,
          curDateTimeType: widget.selectedType,
        ) !=
        -1) {
      return CalendarDateTimeMaker(
        size: 35,
        day: '${dateTime.day}',
        color: widget.color,
        height: 7,
      );
    }

    return null;
  }

  Widget? dowBuilder(bool isLight, DateTime dateTime) {
    String locale = context.locale.toString();
    Color color = dateTime.weekday == 6
        ? blue.original
        : dateTime.weekday == 7
            ? red.original
            : isLight
                ? textColor
                : Colors.white;

    return CommonText(
      text: eFormatter(locale: locale, dateTime: dateTime),
      color: color,
      initFontSize: widget.fontSize - 1,
      isBold: !isLight,
      isNotTr: true,
    );
  }

  Widget? defaultBuilder(bool isLight, DateTime dateTime) {
    Color color = dateTime.weekday == 6
        ? blue.original
        : dateTime.weekday == 7
            ? red.original
            : isLight
                ? textColor
                : Colors.white;

    return Column(
      children: [
        CommonSpace(height: 13.5),
        CommonText(
          text: '${dateTime.day}',
          color: color,
          isBold: !isLight,
          isNotTr: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Expanded(
      child: CommonContainer(
        innerPadding: const EdgeInsets.all(0),
        child: TableCalendar(
          locale: locale,
          headerStyle: calendarHeaderStyle(isLight),
          calendarStyle: calendarDetailStyle(isLight),
          focusedDay: widget.focusedDay,
          firstDay: DateTime(2000, 1, 1),
          lastDay: DateTime(3000, 1, 1),
          onDaySelected: (dateTime, _) => widget.onSelectionDay(dateTime),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (cx, dateTime, _) =>
                defaultBuilder(isLight, dateTime),
            dowBuilder: (cx, dateTime) => dowBuilder(isLight, dateTime),
            markerBuilder: (btx, dateTime, _) => markerBuilder(
              locale,
              dateTime,
              isLight,
            ),
          ),
        ),
      ),
    );
  }
}
