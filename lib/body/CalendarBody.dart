import 'package:flutter/material.dart';
import 'package:todo_tracker_app/body/calendar/CalendarAppBar.dart';
import 'package:todo_tracker_app/body/calendar/CalendarMemo.dart';
import 'package:todo_tracker_app/body/calendar/CalendarTodo.dart';
import 'package:todo_tracker_app/body/calendar/CalendarView.dart';
import 'package:todo_tracker_app/util/enum.dart';

class CalendarBody extends StatefulWidget {
  const CalendarBody({super.key});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  SegmentedTypeEnum selectedSegment = SegmentedTypeEnum.todo;

  onSegmentedChanged(type) {
    setState(() => selectedSegment = type!);
  }

  @override
  Widget build(BuildContext context) {
    bool isTodo = selectedSegment == SegmentedTypeEnum.todo;

    return Column(
      children: [
        CalendarAppBar(
          selectedSegment: selectedSegment,
          onSegmentedChanged: onSegmentedChanged,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CalendarView(selectedSegment: selectedSegment),
                isTodo ? CalendarTodo() : CalendarMemo()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
