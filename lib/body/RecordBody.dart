import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/body/record/RecordAppBar.dart';
import 'package:todo_tracker_app/body/record/RecordCalendar.dart';
import 'package:todo_tracker_app/body/record/RecordContainer.dart';
import 'package:todo_tracker_app/body/record/RecordMemo.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
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
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;

    List<TaskOrderClass> taskOrderList = userInfo.taskOrderList;

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
                    groupInfoList: groupInfoList,
                    taskOrderList: taskOrderList,
                    calendarFormat: calendarFormat,
                    onFormatChanged: onFormatChanged,
                  ),
                  RecordMemo(),
                  const RecordContainer()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
