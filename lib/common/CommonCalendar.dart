import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class CommonCalendar extends StatefulWidget {
  CommonCalendar({
    super.key,
    required this.selectedDateTime,
    required this.calendarFormat,
    required this.shouldFillViewport,
    required this.markerBuilder,
    required this.initFontSize,
    required this.onPageChanged,
    required this.onDaySelected,
    required this.onFormatChanged,
    this.outsideBuilder,
    this.todayBuilder,
    this.rowHeight,
    this.height,
    this.outsideDaysVisible,
  });

  DateTime selectedDateTime;
  CalendarFormat calendarFormat;
  bool shouldFillViewport;
  double initFontSize;
  double? rowHeight, height;
  bool? outsideDaysVisible;
  Function(bool, DateTime) markerBuilder;
  Function(bool, DateTime)? todayBuilder, outsideBuilder;
  Function(DateTime) onPageChanged, onDaySelected;
  Function(CalendarFormat) onFormatChanged;

  @override
  State<CommonCalendar> createState() => _CommonCalendarState();
}

class _CommonCalendarState extends State<CommonCalendar> {
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
      initFontSize: widget.initFontSize - 1,
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

    tableCalendar() {
      return TableCalendar(
        locale: locale,
        rowHeight: widget.rowHeight ?? 52,
        shouldFillViewport: widget.shouldFillViewport,
        calendarStyle: CalendarStyle(
          outsideDaysVisible: widget.outsideDaysVisible ?? true,
          cellMargin: const EdgeInsets.all(14),
          cellAlignment: widget.shouldFillViewport
              ? Alignment.topCenter
              : Alignment.center,
          todayDecoration: BoxDecoration(
            color: isLight ? indigo.s300 : calendarSelectedDateTimeBgColor,
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(
            color: isLight ? Colors.white : calendarSelectedDateTimeTextColor,
            fontWeight: isLight ? FontWeight.bold : null,
            fontSize: widget.initFontSize - 2,
          ),
        ),
        availableGestures: widget.shouldFillViewport
            ? AvailableGestures.horizontalSwipe
            : AvailableGestures.all,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (cx, dateTime, _) =>
              defaultBuilder(isLight, dateTime),
          dowBuilder: (cx, dateTime) => dowBuilder(isLight, dateTime),
          markerBuilder: (cx, dateTime, _) =>
              widget.markerBuilder(isLight, dateTime),
          todayBuilder: widget.todayBuilder != null
              ? (cx, dateTime, _) => widget.todayBuilder!(isLight, dateTime)
              : null,
          outsideBuilder: (cx, dateTime, _) => widget.outsideBuilder != null
              ? widget.outsideBuilder!(isLight, dateTime)
              : null,
        ),
        headerVisible: false,
        daysOfWeekHeight: 22,
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(3000, 1, 1),
        currentDay: widget.selectedDateTime,
        focusedDay: widget.selectedDateTime,
        calendarFormat: widget.calendarFormat,
        availableCalendarFormats: availableCalendarFormats,
        onPageChanged: widget.onPageChanged,
        onDaySelected: (dateTime, _) => widget.onDaySelected(dateTime),
        onFormatChanged: widget.onFormatChanged,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CommonContainer(
        color: isLight ? Colors.white : darkContainerColor,
        innerPadding: const EdgeInsets.symmetric(vertical: 15),
        height: widget.height ??
            (widget.shouldFillViewport
                ? MediaQuery.of(context).size.height / (isTablet ? 1.3 : 1.4)
                : null),
        child: tableCalendar(),
      ),
    );
  }
}
