import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonDivider.dart';
import 'package:todo_tracker_app/common/CommonModalItem.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/common/CommonOutlineInputField.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonSvgText.dart';
import 'package:todo_tracker_app/common/CommonTag.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/bottomSheet/DateTimeBottomSheet.dart';
import 'package:todo_tracker_app/widget/bottomSheet/GroupBottomSheet.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  TextEditingController controller = TextEditingController();

  onDateTime() {
    DateTime now = DateTime.now();
    // String colorName = widget.groupInfo.colorName;
    // ColorClass color = getColorClass(colorName);
    String colorName = '남색';
    ColorClass color = getColorClass(colorName);

    // 날짜
    // DateTimeInfoClass dateTimeInfo = DateTimeInfoClass(
    //   type: widget.taskInfo.dateTimeType,
    //   dateTimeList: widget.taskInfo.dateTimeList,
    // );

    DateTimeInfoClass dateTimeInfo = DateTimeInfoClass(
      type: dateTimeType.selection,
      dateTimeList: [DateTime.now()],
    );

    onUpdate(DateTimeInfoClass dateTimeInfo) async {
      // String groupId = widget.groupInfo.gid;

      // widget.taskInfo.dateTimeType = taskDateTimeInfo.type;
      // widget.taskInfo.dateTimeList = taskDateTimeInfo.dateTimeList;

      // await groupMethod.updateGroup(gid: groupId, groupInfo: widget.groupInfo);

      navigatorPop(context);
      setState(() {});
    }

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => DateTimeBottomSheet(
        color: color,
        dateTimeInfo: dateTimeInfo,
        onSelection: (selectionDays) {
          dateTimeInfo.type = dateTimeType.selection;
          dateTimeInfo.dateTimeList = selectionDays;

          onUpdate(dateTimeInfo);
        },
        onWeek: (weekDays) {
          dateTimeInfo.type = dateTimeType.everyWeek;
          dateTimeInfo.dateTimeList = weekDays
              .where((weekDay) => weekDay.isVisible)
              .map((weekday) =>
                  now.subtract(Duration(days: now.weekday - weekday.id)))
              .toList();

          onUpdate(dateTimeInfo);
        },
        onMonth: (monthDays) {
          dateTimeInfo.type = dateTimeType.everyMonth;
          dateTimeInfo.dateTimeList = monthDays
              .where((monthDay) => monthDay.isVisible)
              .map((monthDay) => DateTime(now.year, 1, monthDay.id))
              .toList();

          onUpdate(dateTimeInfo);
        },
      ),
    );
  }

  onGroup() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => GroupBottomSheet(),
    );
  }

  onEditingComplete() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    bool isLight = context.watch<ThemeProvider>().isLight;
    ColorClass color = getColorClass('남색');

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
                child: CommonSvgText(
                  text: ymdeFormatter(locale: locale, dateTime: DateTime.now()),
                  textColor: grey.original,
                  svgName: 'dir-right-s',
                  svgColor: Colors.grey,
                  svgWidth: 5,
                  svgDirection: SvgDirectionEnum.right,
                ),
              ),
              CommonModalItem(
                title: '그룹',
                vertical: 12.5,
                onTap: onGroup,
                child: CommonTag(
                  text: '할 일',
                  textColor: color.original,
                  bgColor: color.s50,
                  onTap: onGroup,
                ),
              ),
              CommonSpace(height: 15),
              CommonOutlineInputField(
                controller: controller,
                hintText: '할 일을 입력해주세요',
                selectedColor: isLight ? color.s200 : color.s300,
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
