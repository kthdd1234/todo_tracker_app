import 'package:flutter/material.dart';
import 'package:todo_tracker_app/body/calendar/CalendarMemo.dart';
import 'package:todo_tracker_app/body/calendar/CalendarTodo.dart';
import 'package:todo_tracker_app/body/calendar/CalendarView.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/util/enum.dart';

class CalendarScreenTablet extends StatelessWidget {
  CalendarScreenTablet({super.key, required this.selectedSegment});

  SegmentedTypeEnum selectedSegment;

  @override
  Widget build(BuildContext context) {
    bool isTodo = selectedSegment == SegmentedTypeEnum.todo;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: CalendarView(selectedSegment: selectedSegment),
          ),
        ),
        CommonSpace(width: 15),
        Expanded(
          child: SingleChildScrollView(
            child: isTodo ? const CalendarTodo() : const CalendarMemo(),
          ),
        )
      ],
    );
  }
}
