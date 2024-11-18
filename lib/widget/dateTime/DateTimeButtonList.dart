import 'package:flutter/material.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/widget/button/DateTimeButton.dart';

class DateTimeButtonList extends StatelessWidget {
  DateTimeButtonList({
    super.key,
    required this.color,
    required this.selectedType,
    required this.onTap,
  });

  ColorClass color;
  String selectedType;
  Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          DateTimeButton(
            text: '선택',
            color: color,
            type: dateTimeType.selection,
            selectedType: selectedType,
            onTap: onTap,
          ),
          CommonSpace(width: 5),
          DateTimeButton(
            text: '매주',
            color: color,
            type: dateTimeType.everyWeek,
            selectedType: selectedType,
            onTap: onTap,
          ),
          CommonSpace(width: 5),
          DateTimeButton(
            text: '매달',
            color: color,
            type: dateTimeType.everyMonth,
            selectedType: selectedType,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
