import 'package:flutter/material.dart';
import 'package:todo_tracker_app/common/CommonButton.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/widget/dateTime/DateTimeAlertInfo.dart';

class MonthDay extends StatelessWidget {
  MonthDay({
    super.key,
    required this.textColor,
    required this.buttonColor,
    required this.monthDays,
    required this.onMonthDay,
  });

  List<MonthDayClass> monthDays;
  Function(MonthDayClass) onMonthDay;
  Function(bool) textColor, buttonColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CommonSpace(height: 5),
          GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 7,
              mainAxisSpacing: 7,
              mainAxisExtent: isTablet ? 40 : null,
            ),
            children: monthDays
                .map((monthDay) => CommonButton(
                      text: monthDay.id.toString(),
                      isNotTr: true,
                      isBold: monthDay.isVisible,
                      textColor: textColor(monthDay.isVisible),
                      buttonColor: buttonColor(monthDay.isVisible),
                      verticalPadding: 10,
                      borderRadius: 7,
                      onTap: () => onMonthDay(monthDay),
                    ))
                .toList(),
          ),
          const Spacer(),
          DateTimeAlertInfo(text: '매달 선택 시 내일 할래요 기능을 사용할 수 없어요.')
        ],
      ),
    );
  }
}
