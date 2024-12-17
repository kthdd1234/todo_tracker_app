import 'package:flutter/material.dart';
import 'package:todo_tracker_app/body/calendar/CalendarAppBar.dart';
import 'package:todo_tracker_app/body/calendar/calendarScreen/CalendarScreenPhone.dart';
import 'package:todo_tracker_app/body/calendar/calendarScreen/CalendarScreenTablet.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/final.dart';

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
    return Column(
      children: [
        CalendarAppBar(
          selectedSegment: selectedSegment,
          onSegmentedChanged: onSegmentedChanged,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: isTablet
                ? CalendarScreenTablet(selectedSegment: selectedSegment)
                : CalendarScreenPhone(selectedSegment: selectedSegment),
          ),
        )
      ],
    );
  }
}
