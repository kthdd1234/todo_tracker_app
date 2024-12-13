import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/body/record/recordCalendar/RecordCalendarMemo.dart';
import 'package:todo_tracker_app/body/record/recordCalendar/RecordCalendarStickerList.dart';
import 'package:todo_tracker_app/common/CommonCalendar.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/TitleDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class RecordCalendar extends StatefulWidget {
  RecordCalendar({super.key});

  @override
  State<RecordCalendar> createState() => _RecordCalendarState();
}

class _RecordCalendarState extends State<RecordCalendar> {
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
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;
    List<GroupInfoClass> groupInfoOrderList =
        getGroupInfoOrderList(userInfo.groupOrderList, groupInfoList);

    Widget? stickerBuilder(bool isLight, DateTime dateTime) {
      String locale = context.locale.toString();
      List<StickerClass> stickerList = [];

      List<RecordItemClass> recordItemList = getRecordItemList(
        locale: locale,
        targetDateTime: dateTime,
        groupInfoList: groupInfoOrderList,
        taskOrderList: userInfo.taskOrderList,
      );

      for (final recordItem in recordItemList) {
        List<RecordInfoClass> recordInfoList =
            recordItem.taskInfo.recordInfoList;
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
          RecordCalendarMemo(dateTime: dateTime),
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

    Widget? todayBuilder(isLight, dateTime) {
      return Column(
        children: [
          CommonSpace(height: 12),
          CircleAvatar(
            radius: 13,
            backgroundColor: isLight ? indigo.s300 : Colors.white,
            child: CommonText(
              text: '${dateTime.day}',
              color: isLight ? Colors.white : darkButtonColor,
              isNotTr: true,
            ),
          ),
        ],
      );
    }

    return CommonCalendar(
      rowHeight: 55,
      initFontSize: fontSize,
      selectedDateTime: selectedDateTime,
      calendarFormat: CalendarFormat.month,
      shouldFillViewport: false,
      outsideDaysVisible: false,
      markerBuilder: stickerBuilder,
      todayBuilder: todayBuilder,
      onPageChanged: onPageChanged,
      onDaySelected: onDaySelected,
      onFormatChanged: (_) {},
    );
  }
}
