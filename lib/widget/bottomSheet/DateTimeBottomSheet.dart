import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonButton.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonModalSheet.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/dateTime/DateTimeButtonList.dart';
import 'package:todo_tracker_app/widget/dateTime/MonthDay.dart';
import 'package:todo_tracker_app/widget/dateTime/SelectionDay.dart';
import 'package:todo_tracker_app/widget/dateTime/WeekDay.dart';

class DateTimeBottomSheet extends StatefulWidget {
  DateTimeBottomSheet({
    super.key,
    required this.color,
    required this.dateTimeInfo,
    required this.onSelection,
    required this.onWeek,
    required this.onMonth,
  });

  ColorClass color;
  DateTimeInfoClass dateTimeInfo;
  Function(List<DateTime>) onSelection;
  Function(List<WeekDayClass>) onWeek;
  Function(List<MonthDayClass>) onMonth;

  @override
  State<DateTimeBottomSheet> createState() => _DateTimeBottomSheetState();
}

class _DateTimeBottomSheetState extends State<DateTimeBottomSheet> {
  String selectedType = dateTimeType.selection;
  DateTime focusedDay = DateTime.now();

  List<DateTime> selectionDays = [DateTime.now()];
  List<WeekDayClass> weekDays = List.generate(
    dayLabels.length,
    (index) => WeekDayClass(
      id: index + 1,
      name: dayLabels[index],
      isVisible: false,
    ),
  ).toList();
  List<MonthDayClass> monthDays = [for (var i = 1; i <= 31; i++) i]
      .map((id) => MonthDayClass(id: id, isVisible: false))
      .toList();

  @override
  void initState() {
    List<DateTime> dateTimeList = widget.dateTimeInfo.dateTimeList;
    selectedType = widget.dateTimeInfo.type;

    if (selectedType == dateTimeType.selection) {
      selectionDays = dateTimeList;
      focusedDay = selectionDays[0];
    } else if (selectedType == dateTimeType.everyWeek) {
      for (var dateTime in dateTimeList) {
        weekDays[dateTime.weekday - 1].isVisible = true;
      }
    } else if (selectedType == dateTimeType.everyMonth) {
      for (var dateTime in dateTimeList) {
        monthDays[dateTime.day - 1].isVisible = true;
      }
    }

    super.initState();
  }

  onChangeType(String type) {
    DateTime now = DateTime.now();

    setState(() {
      if (type == dateTimeType.everyWeek && isEmptyWeekDays(weekDays)) {
        weekDays[now.weekday - 1].isVisible = true;
      } else if (type == dateTimeType.everyMonth &&
          isEmptyMonthDays(monthDays)) {
        monthDays[now.day - 1].isVisible = true;
      }

      selectedType = type;
    });
  }

  onSelectionDay(DateTime dateTime) {
    setState(() {
      focusedDay = dateTime;

      selectionDays = [];
      selectionDays.add(dateTime);
    });
  }

  onWeekDay(WeekDayClass weekDay) {
    setState(() {
      weekDays = weekDays.map((item) {
        if (item.id == weekDay.id) {
          item.isVisible = !weekDay.isVisible;
        }

        return item;
      }).toList();
    });
  }

  onMonthDay(MonthDayClass monthDay) {
    bool isVisible = !monthDay.isVisible;

    setState(() {
      monthDays = monthDays.map((item) {
        if (item.id == monthDay.id) {
          item.isVisible = isVisible;
        }

        return item;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isCompletedSelection = selectionDays.isNotEmpty;
    bool isCompletedWeek =
        weekDays.where((item) => item.isVisible).toList().isNotEmpty;
    bool isCompletedMonth =
        monthDays.where((item) => item.isVisible).toList().isNotEmpty;

    bool isSelection = selectedType == dateTimeType.selection;
    bool isWeek = selectedType == dateTimeType.everyWeek;
    bool isMonth = selectedType == dateTimeType.everyMonth;

    bool isLight = context.watch<ThemeProvider>().isLight;
    Color notTextColor = isLight ? grey.s400 : Colors.white;
    Color notBgColor = isLight ? whiteBgBtnColor : darkNotSelectedBgColor;

    double fontSize = context.watch<FontSizeProvider>().fintSize;

    onTextColor(bool isVisible) {
      return isVisible ? Colors.white : notTextColor;
    }

    onButtonColor(bool isVisible) {
      return isVisible
          ? isLight
              ? widget.color.s200
              : widget.color.s300
          : notBgColor;
    }

    onTextCompletedColor() {
      return onTextColor(
        isSelection
            ? isCompletedSelection
            : isWeek
                ? isCompletedWeek
                : isCompletedMonth,
      );
    }

    onButtonCompletedColor() {
      return onButtonColor(
        isSelection
            ? isCompletedSelection
            : isWeek
                ? isCompletedWeek
                : isCompletedMonth,
      );
    }

    onCompleted() {
      if (isSelection) {
        isCompletedSelection ? widget.onSelection(selectionDays) : null;
      } else if (isWeek) {
        isCompletedWeek ? widget.onWeek(weekDays) : null;
      } else if (isMonth) {
        isCompletedMonth ? widget.onMonth(monthDays) : null;
      }
    }

    Widget child = {
      dateTimeType.selection: SelectionDay(
        fontSize: fontSize,
        selectedType: selectedType,
        focusedDay: focusedDay,
        selectionDays: selectionDays,
        color: widget.color,
        onSelectionDay: onSelectionDay,
      ),
      dateTimeType.everyWeek: WeekDay(
        weekDays: weekDays,
        textColor: onTextColor,
        buttonColor: onButtonColor,
        onWeekDay: onWeekDay,
      ),
      dateTimeType.everyMonth: MonthDay(
        monthDays: monthDays,
        textColor: onTextColor,
        buttonColor: onButtonColor,
        onMonthDay: onMonthDay,
      ),
    }[selectedType]!;

    double height = {
      dateTimeType.selection: 637.0,
      dateTimeType.everyWeek: 330.0,
      dateTimeType.everyMonth: isTablet ? 550.0 : 560.0,
    }[selectedType]!;

    return CommonModalSheet(
      title: '날짜를 설정해주세요',
      isBack: true,
      height: height,
      child: Column(
        children: [
          Expanded(
            child: CommonContainer(
              child: Column(
                children: [
                  DateTimeButtonList(
                    color: widget.color,
                    selectedType: selectedType,
                    onTap: onChangeType,
                  ),
                  child
                ],
              ),
            ),
          ),
          CommonButton(
            text: '완료',
            textColor: onTextCompletedColor(),
            buttonColor: onButtonCompletedColor(),
            outerPadding: const EdgeInsets.only(top: 15),
            verticalPadding: 15,
            isBold: true,
            borderRadius: 100,
            onTap: onCompleted,
          )
        ],
      ),
    );
  }
}
