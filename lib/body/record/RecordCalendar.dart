import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/common/CommonCalendar.dart';
import 'package:todo_tracker_app/common/CommonCircle.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/TitleDateTimeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class RecordCalendar extends StatefulWidget {
  RecordCalendar({
    super.key,
    required this.calendarFormat,
    required this.onFormatChanged,
  });

  CalendarFormat calendarFormat;
  Function() onFormatChanged;

  @override
  State<RecordCalendar> createState() => _RecordCalendarState();
}

class _RecordCalendarState extends State<RecordCalendar> {
  Widget? stickerBuilder(bool isLight, DateTime dateTime) {
    String locale = context.locale.toString();
    List<ColorClass?> colorList = [];

    // for (var groupInfo in widget.groupInfoList) {
    //   List<TaskInfoClass> taskInfoList = getTaskInfoList(
    //     locale: locale,
    //     groupInfo: groupInfo,
    //     targetDateTime: dateTime,
    //   );

    //   bool isRecord = taskInfoList.any((taskInfo) {
    //     return taskInfo.recordInfoList.any((record) =>
    //         (record.dateTimeKey == dateTimeKey(dateTime)) &&
    //         (record.mark != null));
    //   });

    //   if (colorList.length != 6 && isRecord) {
    //     colorList.add(getColorClass(groupInfo.colorName));
    //   }
    // }

    while (colorList.length < 6) {
      colorList.add(null);
    }

    wCircle(ColorClass? color) {
      return CommonCircle(
        color: (isLight ? color?.s200 : color?.s300) ?? Colors.transparent,
        size: 5,
        padding: const EdgeInsets.symmetric(horizontal: 1),
      );
    }

    wRow(List<ColorClass?> list) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list.map((color) => wCircle(color)).toList(),
      );
    }

    // int index = widget.memoInfoList.indexWhere(
    //   (memoInfo) => memoInfo.dateTimeKey == dateTimeKey(dateTime),
    // );
    // MemoInfoClass? memoInfo = index != -1 ? widget.memoInfoList[index] : null;
    // bool isMemo = (memoInfo?.imgUrl != null) || (memoInfo?.text != null);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // isMemo
        //     ? Container(
        //         width: 21,
        //         height: 3,
        //         decoration: BoxDecoration(
        //           color: isLight ? orange.s100 : orange.s300,
        //           borderRadius: BorderRadius.circular(3),
        //         ),
        //       )
        //     : const CommonNull(),
        CommonSpace(height: 3),
        Column(
          children: [
            wRow(colorList.sublist(0, 3)),
            CommonSpace(height: 2),
            wRow(colorList.sublist(3, 6)),
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
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

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
