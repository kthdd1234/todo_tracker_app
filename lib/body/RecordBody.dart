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
import 'package:todo_tracker_app/util/func.dart';

class RecordBody extends StatefulWidget {
  const RecordBody({super.key});

  @override
  State<RecordBody> createState() => _RecordBodyState();
}

class _RecordBodyState extends State<RecordBody> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          RecordAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RecordCalendar(),
                  const RecordMemo(),
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
