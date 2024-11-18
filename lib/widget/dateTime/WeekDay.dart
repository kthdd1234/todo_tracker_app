import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonButton.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/widget/dateTime/DateTimeAlertInfo.dart';

class WeekDay extends StatelessWidget {
  WeekDay({
    super.key,
    required this.textColor,
    required this.buttonColor,
    required this.weekDays,
    required this.onWeekDay,
  });

  List<WeekDayClass> weekDays;
  Function(WeekDayClass) onWeekDay;
  Function(bool) textColor, buttonColor;

  @override
  Widget build(BuildContext context) {
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: weekDays
                .map((item) => Expanded(
                      child: CommonButton(
                        text: item.name,
                        initFontSize: fontSize - 1,
                        isBold: item.isVisible,
                        textColor: textColor(item.isVisible),
                        buttonColor: buttonColor(item.isVisible),
                        verticalPadding: 10,
                        outerPadding: EdgeInsets.only(
                          right: item.id == weekDays.last.id ? 0 : 5,
                        ),
                        borderRadius: 7,
                        onTap: () => onWeekDay(item),
                      ),
                    ))
                .toList(),
          ),
          const Spacer(),
          DateTimeAlertInfo(text: '매주 선택 시 내일 할래요 기능을 사용할 수 없어요.')
        ],
      ),
    );
  }
}
