import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/common/CommonCloseButton.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonModalButton.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonTag.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/bottomSheet/TaskBottomSheet.dart';
import 'package:todo_tracker_app/widget/dateTime/CalendarDateTimeMaker.dart';

class TaskInfoBottomSheet extends StatefulWidget {
  TaskInfoBottomSheet({super.key, required this.groupInfo});

  GroupInfoClass groupInfo;

  @override
  State<TaskInfoBottomSheet> createState() => _TaskInfoBottomSheetState();
}

class _TaskInfoBottomSheetState extends State<TaskInfoBottomSheet> {
  DateTime titleDateTime = DateTime.now();
  DateTime focusedDay = DateTime.now();

  Widget? markerBuilder(
    bool isLight,
    DateTime dateTime,
    String locale,
  ) {
    int idx = isContainIdxDateTime(
      locale: locale,
      selectionList: [DateTime.now()],
      targetDateTime: dateTime,
      curDateTimeType: dateTimeType.selection,
    );
    String colorName = '남색'; // widget.groupInfo.colorName;
    ColorClass color = getColorClass(colorName);
    String? mark = null;
    // String? mark = getRecordInfo(
    //   recordInfoList: widget.taskInfo.recordInfoList,
    //   targetDateTime: dateTime,
    // )?.mark;

    if (idx != -1) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 3),
            child: CalendarDateTimeMaker(
              size: 25,
              day: '${dateTime.day}',
              isLight: isLight,
              color: color,
              borderRadius: 5,
            ),
          ),
          mark != null
              ? svgAsset(name: 'mark-$mark', width: 15, color: color.s300)
              : const CommonNull()
        ],
      );
    }

    return null;
  }

  Widget? defaultBuilder(bool isLight, DateTime dateTime) {
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

  Widget? dowBuilder(bool isLight, DateTime dateTime, double fontSize) {
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

  Widget? todayBuilder(bool isLight, DateTime dateTime) {
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

  onPageChanged(DateTime dateTime) {
    setState(() => titleDateTime = dateTime);
  }

  onRemove() {
    //
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    String locale = context.locale.toString();
    ColorClass color = getColorClass('남색');
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    onEdit() {
      navigatorPop(context);
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => TaskBottomSheet(
          groupInfo: widget.groupInfo,
          selectedDateTime: selectedDateTime,
        ),
      );
    }

    return CommonModalSheet(
      title: '테스트용',
      height: 680,
      isNotTr: true,
      actionButton: const ModalCloseButton(),
      child: Column(
        children: [
          CommonContainer(
            innerPadding: const EdgeInsets.all(5),
            height: 480,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      CommonTag(
                        text: dateTimeLabel['selection']!,
                        isBold: true,
                        textColor: Colors.white,
                        bgColor: isLight ? color.s300 : color.s400,
                        initFontSize: fontSize - 3,
                        onTap: () {},
                      )
                    ],
                  ),
                ),
                TableCalendar(
                  locale: locale,
                  rowHeight: 64,
                  headerVisible: false,
                  sixWeekMonthsEnforced: true,
                  focusedDay: titleDateTime,
                  firstDay: DateTime(2000, 1, 1),
                  lastDay: DateTime(3000, 1, 1),
                  calendarStyle:
                      const CalendarStyle(cellAlignment: Alignment.center),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (btx, dateTime, _) => markerBuilder(
                      isLight,
                      dateTime,
                      locale,
                    ),
                    defaultBuilder: (cx, dateTime, _) =>
                        defaultBuilder(isLight, dateTime),
                    dowBuilder: (cx, dateTime) =>
                        dowBuilder(isLight, dateTime, fontSize),
                    todayBuilder: (cx, dateTime, __) =>
                        todayBuilder(isLight, dateTime),
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
                actionText: '수정',
                isBold: !isLight,
                color: isLight ? textColor : darkTextColor,
                onTap: onEdit,
              ),
              CommonSpace(width: 5),
              CommonModalButton(
                svgName: 'remove',
                actionText: '삭제',
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
