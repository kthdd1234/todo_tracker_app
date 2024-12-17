import 'package:flutter/material.dart';
import 'package:todo_tracker_app/body/calendar/CalendarMemo.dart';
import 'package:todo_tracker_app/body/calendar/CalendarTodo.dart';
import 'package:todo_tracker_app/body/calendar/CalendarView.dart';
import 'package:todo_tracker_app/util/enum.dart';

class CalendarScreenPhone extends StatelessWidget {
  CalendarScreenPhone({super.key, required this.selectedSegment});

  SegmentedTypeEnum selectedSegment;

  @override
  Widget build(BuildContext context) {
    bool isTodo = selectedSegment == SegmentedTypeEnum.todo;

    return Column(
      children: [
        CalendarView(selectedSegment: selectedSegment),
        isTodo ? const CalendarTodo() : const CalendarMemo()
      ],
    );
  }
}
