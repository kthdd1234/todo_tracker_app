import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/body/record/RecordAppBar.dart';
import 'package:todo_tracker_app/body/record/RecordCalendar.dart';
import 'package:todo_tracker_app/body/record/RecordContainer.dart';
import 'package:todo_tracker_app/util/final.dart';

class RecordBody extends StatefulWidget {
  const RecordBody({super.key});

  @override
  State<RecordBody> createState() => _RecordBodyState();
}

class _RecordBodyState extends State<RecordBody> {
  CalendarFormat calendarFormat = CalendarFormat.week;

  onFormatChanged() {
    setState(() => calendarFormat = nextCalendarFormats[calendarFormat]!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          RecordAppBar(
            calendarFormat: calendarFormat,
            onFormatChanged: onFormatChanged,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RecordCalendar(
                    calendarFormat: calendarFormat,
                    onFormatChanged: onFormatChanged,
                  ),
                  RecordContainer()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
