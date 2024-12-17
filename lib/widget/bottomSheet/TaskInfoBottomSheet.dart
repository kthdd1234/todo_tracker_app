import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/common/CommonCloseButton.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonModalButton.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonTag.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/PremiumProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/bottomSheet/TaskBottomSheet.dart';
import 'package:todo_tracker_app/widget/dateTime/CalendarDateTimeMaker.dart';

class TaskInfoBottomSheet extends StatefulWidget {
  TaskInfoBottomSheet({
    super.key,
    required this.groupInfo,
    required this.taskInfo,
    required this.initDateTime,
  });

  GroupInfoClass groupInfo;
  TaskInfoClass taskInfo;
  DateTime initDateTime;

  @override
  State<TaskInfoBottomSheet> createState() => _TaskInfoBottomSheetState();
}

class _TaskInfoBottomSheetState extends State<TaskInfoBottomSheet> {
  DateTime titleDateTime = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    titleDateTime = widget.initDateTime;
    focusedDay = widget.initDateTime;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    bool isPremium = context.watch<PremiumProvider>().isPremium;
    bool isLight = context.watch<ThemeProvider>().isLight;
    ColorClass color = getColorClass(widget.groupInfo.colorName);
    List<TaskOrderClass> taskOrderList =
        context.watch<UserInfoProvider>().userInfo.taskOrderList;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    Widget onTag({required String text}) {
      return CommonTag(
        text: text,
        isBold: !isLight,
        textColor: isLight ? color.original : Colors.white,
        bgColor: isLight ? color.s50 : color.s400,
        initFontSize: fontSize - 3,
        isNotTr: true,
        onTap: () {},
      );
    }

    Widget? todayBuilder(DateTime dateTime) {
      Color color = dateTime.weekday == 6
          ? blue.original
          : dateTime.weekday == 7
              ? red.original
              : isLight
                  ? Colors.black
                  : Colors.white;

      return Padding(
        padding: const EdgeInsets.only(top: 21),
        child: Column(
          children: [
            CommonText(
              text: '${dateTime.day}',
              color: color,
              isNotTr: true,
            )
          ],
        ),
      );
    }

    Widget? defaultBuilder(DateTime dateTime) {
      Color color = dateTime.weekday == 6
          ? blue.original
          : dateTime.weekday == 7
              ? red.original
              : isLight
                  ? Colors.black
                  : Colors.white;

      return Column(
        children: [
          CommonSpace(height: 22),
          CommonText(text: '${dateTime.day}', color: color, isNotTr: true),
        ],
      );
    }

    Widget? dowBuilder(DateTime dateTime) {
      String locale = context.locale.toString();
      Color color = dateTime.weekday == 6
          ? blue.original
          : dateTime.weekday == 7
              ? red.original
              : isLight
                  ? Colors.black
                  : Colors.white;

      return CommonText(
        text: eFormatter(locale: locale, dateTime: dateTime),
        color: color,
        initFontSize: fontSize - 1, // 13
        isNotTr: true,
      );
    }

    Widget? markerBuilder(DateTime dateTime) {
      int idx = isContainIdxDateTime(
        locale: locale,
        targetDateTime: dateTime,
        curDateTimeType: widget.taskInfo.dateTimeType,
        selectionList: widget.taskInfo.dateTimeList,
      );
      String? mark = getRecordInfo(
        recordInfoList: widget.taskInfo.recordInfoList,
        targetDateTime: dateTime,
      )?.mark;

      if (idx != -1) {
        return CalendarDateTimeMaker(
          size: 25,
          day: '${dateTime.day}',
          color: color,
          borderRadius: 5,
          mark: mark,
        );
      }

      return null;
    }

    onPageChanged(DateTime dateTime) {
      setState(() => titleDateTime = dateTime);
    }

    onEdit() {
      navigatorPop(context);

      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => TaskBottomSheet(
          isPremium: isPremium,
          selectedDateTime: widget.initDateTime,
          groupInfo: widget.groupInfo,
          taskInfo: widget.taskInfo,
        ),
      );
    }

    onRemove() async {
      /// task order id 삭제
      for (final taskOrder in taskOrderList) {
        taskOrder.list.removeWhere((taskId) => taskId == widget.taskInfo.tid);
      }

      // task 삭제
      widget.groupInfo.taskInfoList
          .removeWhere((taskInfo) => taskInfo.tid == widget.taskInfo.tid);

      // group data 업데이트
      await groupMethod.updateGroup(
        gid: widget.groupInfo.gid,
        groupInfo: widget.groupInfo,
      );

      navigatorPop(context);
    }

    return CommonModalSheet(
      title: widget.taskInfo.name,
      height: 600,
      isNotTr: true,
      actionButton: const ModalCloseButton(),
      child: Column(
        children: [
          CommonContainer(
            innerPadding: const EdgeInsets.all(5),
            height: 400,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    children: [
                      CommonText(
                        text: yMFormatter(
                          locale: locale,
                          dateTime: titleDateTime,
                        ),
                        initFontSize: fontSize + 2,
                        isNotTr: true,
                        isBold: !isLight,
                      ),
                      const Spacer(),
                      onTag(text: widget.groupInfo.name),
                    ],
                  ),
                ),
                TableCalendar(
                  daysOfWeekHeight: 22,
                  locale: locale,
                  headerVisible: false,
                  focusedDay: titleDateTime,
                  firstDay: DateTime(2000, 1, 1),
                  lastDay: DateTime(3000, 1, 1),
                  calendarStyle: const CalendarStyle(
                    cellAlignment: Alignment.center,
                    outsideDaysVisible: false,
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (btx, dateTime, _) =>
                        markerBuilder(dateTime),
                    defaultBuilder: (cx, dateTime, _) =>
                        defaultBuilder(dateTime),
                    dowBuilder: (cx, dateTime) => dowBuilder(dateTime),
                    todayBuilder: (cx, dateTime, __) => todayBuilder(dateTime),
                  ),
                  onPageChanged: onPageChanged,
                ),
              ],
            ),
          ),
          CommonSpace(height: 10),
          Row(
            children: [
              CommonModalButton(
                svgName: 'highlighter',
                actionText: '수정하기',
                isBold: !isLight,
                color: isLight ? textColor : darkTextColor,
                onTap: onEdit,
              ),
              CommonSpace(width: 5),
              CommonModalButton(
                svgName: 'remove',
                actionText: '삭제하기',
                isBold: !isLight,
                color: red.s200,
                onTap: onRemove,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
