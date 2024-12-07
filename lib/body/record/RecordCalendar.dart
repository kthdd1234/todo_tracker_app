import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/body/record/recordCalendar/RecordCalendarMemo.dart';
import 'package:todo_tracker_app/body/record/recordCalendar/RecordCalendarStickerList.dart';
import 'package:todo_tracker_app/common/CommonCalendar.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/TitleDateTimeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class RecordCalendar extends StatefulWidget {
  RecordCalendar({
    super.key,
    required this.groupInfoList,
    required this.taskOrderList,
    required this.calendarFormat,
    required this.onFormatChanged,
  });

  List<GroupInfoClass> groupInfoList;
  List<TaskOrderClass> taskOrderList;
  CalendarFormat calendarFormat;
  Function() onFormatChanged;

  @override
  State<RecordCalendar> createState() => _RecordCalendarState();
}

class _RecordCalendarState extends State<RecordCalendar> {
  Widget? stickerBuilder(bool isLight, DateTime dateTime) {
    String locale = context.locale.toString();
    List<StickerClass> stickerList = [];

    List<RecordItemClass> recordItemList = getRecordItemList(
      locale: locale,
      targetDateTime: dateTime,
      groupInfoList: widget.groupInfoList,
      taskOrderList: widget.taskOrderList,
    );

    for (final recordItem in recordItemList) {
      List<RecordInfoClass> recordInfoList = recordItem.taskInfo.recordInfoList;
      RecordInfoClass? recordInfo = getRecordInfo(
        recordInfoList: recordInfoList,
        targetDateTime: dateTime,
      );
      String? mark = recordInfo?.mark;
      ColorClass color = getColorClass(recordItem.groupInfo.colorName);
      StickerClass sticker = StickerClass(mark: mark, color: color);

      if (stickerList.length < 6) stickerList.add(sticker);
    }

    return Column(
      children: [
        CommonSpace(height: 37),
        const RecordCalendarMemo(),
        CommonSpace(height: 3),
        Column(
          children: [
            RecordCalendarStickerList(
              start: 0,
              end: 2,
              stickerList: stickerList,
            ),
            CommonSpace(height: 2),
            RecordCalendarStickerList(
              start: 3,
              end: 5,
              stickerList: stickerList,
            ),
          ],
        ),
      ],
    );
  }

  onPageChanged(DateTime dateTime) {
    context
        .read<TitleDateTimeProvider>()
        .changeTitleDateTime(dateTime: dateTime);
  }

  onDaySelected(DateTime dateTime) {
    context
        .read<TitleDateTimeProvider>()
        .changeTitleDateTime(dateTime: dateTime);

    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: dateTime);
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().selectedDateTime;

    return CommonCalendar(
      initFontSize: fontSize,
      selectedDateTime: selectedDateTime,
      calendarFormat: isTablet ? CalendarFormat.month : widget.calendarFormat,
      shouldFillViewport: false,
      markerBuilder: stickerBuilder,
      onPageChanged: onPageChanged,
      onDaySelected: onDaySelected,
      onFormatChanged: (_) => widget.onFormatChanged(),
    );
  }
}
