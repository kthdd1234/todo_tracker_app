import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonModalItem.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/common/CommonOutlineInputField.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonTag.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/bottomSheet/DateTimeBottomSheet.dart';
import 'package:todo_tracker_app/widget/bottomSheet/GroupListBottomSheet.dart';

class TaskBottomSheet extends StatefulWidget {
  TaskBottomSheet({
    super.key,
    required this.selectedDateTime,
    required this.groupInfo,
    this.taskInfo,
  });

  GroupInfoClass groupInfo;
  TaskInfoClass? taskInfo;
  DateTime selectedDateTime;

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  DateTimeInfoClass dateTimeInfo = DateTimeInfoClass(
    type: dateTimeType.selection,
    dateTimeList: [DateTime.now()],
  );
  GroupInfoClass selectedGroupInfo = GroupInfoClass(
    gid: '할 일',
    name: '할 일',
    colorName: '남색',
    createDateTime: DateTime.now(),
    isOpen: true,
    taskInfoList: [],
  );
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    selectedGroupInfo = widget.groupInfo;

    if (widget.taskInfo != null) {
      dateTimeInfo.type = widget.taskInfo!.dateTimeType;
      dateTimeInfo.dateTimeList = widget.taskInfo!.dateTimeList;
      controller.text = widget.taskInfo!.name;
    } else {
      dateTimeInfo.dateTimeList = [widget.selectedDateTime];
    }

    super.initState();
  }

  onDateTime() {
    ColorClass color = getColorClass(selectedGroupInfo.colorName);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => DateTimeBottomSheet(
        color: color,
        dateTimeInfo: dateTimeInfo,
        onSelection: onSelection,
        onWeek: onWeek,
        onMonth: onMonth,
      ),
    );
  }

  onSelection(List<DateTime> selectionDays) {
    dateTimeInfo.type = dateTimeType.selection;
    dateTimeInfo.dateTimeList = selectionDays;

    navigatorPop(context);
  }

  onWeek(List<WeekDayClass> weekDays) {
    DateTime now = DateTime.now();

    dateTimeInfo.type = dateTimeType.everyWeek;
    dateTimeInfo.dateTimeList = weekDays
        .where((weekDay) => weekDay.isVisible)
        .map(
            (weekday) => now.subtract(Duration(days: now.weekday - weekday.id)))
        .toList();

    navigatorPop(context);
  }

  onMonth(List<MonthDayClass> monthDays) {
    DateTime now = DateTime.now();

    dateTimeInfo.type = dateTimeType.everyMonth;
    dateTimeInfo.dateTimeList = monthDays
        .where((monthDay) => monthDay.isVisible)
        .map((monthDay) => DateTime(now.year, 1, monthDay.id))
        .toList();

    navigatorPop(context);
  }

  displayDateTime(String locale) {
    if (dateTimeInfo.type == dateTimeType.selection) {
      String result = ymdeFormatter(
        locale: locale,
        dateTime: dateTimeInfo.dateTimeList[0],
      );

      dateTimeInfo.dateTimeList
          .sort((dtA, dtB) => ymdToInt(dtA).compareTo(ymdToInt(dtB)));

      return '$result${dateTimeInfo.dateTimeList.length > 1 ? '....+${dateTimeInfo.dateTimeList.length - 1}' : ''}';
    } else if (dateTimeInfo.type == dateTimeType.everyWeek) {
      String join = dateTimeInfo.dateTimeList
          .map((dateTime) => eFormatter(locale: locale, dateTime: dateTime))
          .join(', ');

      return '매주 - $join';
    } else if (dateTimeInfo.type == dateTimeType.everyMonth) {
      List<String> list = dateTimeInfo.dateTimeList
          .map((dateTime) => dFormatter(locale: locale, dateTime: dateTime))
          .toList();
      String join = '';
      join = list.length > 5
          ? '${list.sublist(0, 5).join(', ')}...'
          : list.join(', ');

      return '매달 - $join';
    }
  }

  onGroup() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => GroupListBottomSheet(
        selectedGroupInfo: selectedGroupInfo,
        onSelection: (groupInfo) {
          navigatorPop(context);
          setState(() => selectedGroupInfo = groupInfo);
        },
      ),
    );
  }

  onEditingComplete() async {
    if (widget.taskInfo == null) {
      DateTime now = DateTime.now();
      DateTime createDateTime = DateTime(
        widget.selectedDateTime.year,
        widget.selectedDateTime.month,
        widget.selectedDateTime.day,
        now.hour,
        now.minute,
        now.second,
        now.millisecond,
        now.microsecond,
      );

      TaskInfoClass newTaskInfo = TaskInfoClass(
        createDateTime: createDateTime,
        tid: uuid(),
        name: controller.text,
        dateTimeType: dateTimeInfo.type,
        dateTimeList: dateTimeInfo.dateTimeList,
        recordInfoList: [],
      );

      selectedGroupInfo.taskInfoList.add(newTaskInfo);
    } else {
      widget.taskInfo!.dateTimeType = dateTimeInfo.type;
      widget.taskInfo!.dateTimeList = dateTimeInfo.dateTimeList;
      widget.taskInfo!.name = controller.text;
    }

    await groupMethod.updateGroup(
      gid: selectedGroupInfo.gid,
      groupInfo: selectedGroupInfo,
    );

    navigatorPop(context);
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    bool isLight = context.watch<ThemeProvider>().isLight;
    ColorClass groupColor = getColorClass(selectedGroupInfo.colorName);
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: CommonModalSheet(
        title: '할 일 추가',
        height: 257.5,
        child: CommonContainer(
          innerPadding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              CommonSpace(height: 5),
              CommonModalItem(
                title: '날짜',
                onTap: onDateTime,
                child: CommonText(
                  text: displayDateTime(locale),
                  color: grey.original,
                ),
              ),
              CommonModalItem(
                title: '그룹',
                vertical: 12.5,
                onTap: onGroup,
                child: CommonTag(
                  text: selectedGroupInfo.name,
                  initFontSize: fontSize - 1,
                  textColor: groupColor.s400,
                  bgColor: groupColor.s50,
                  onTap: onGroup,
                ),
              ),
              CommonSpace(height: 15),
              CommonOutlineInputField(
                controller: controller,
                hintText: '할 일을 입력해주세요',
                selectedColor: isLight ? groupColor.s200 : groupColor.s300,
                onSuffixIcon: onEditingComplete,
                onEditingComplete: onEditingComplete,
                onChanged: (_) => setState(() {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
