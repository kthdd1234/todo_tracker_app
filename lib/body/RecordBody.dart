import 'package:flutter/material.dart';
import 'package:todo_tracker_app/body/record/RecordAppBar.dart';
import 'package:todo_tracker_app/body/record/RecordCalendar.dart';
import 'package:todo_tracker_app/body/record/RecordContainer.dart';
import 'package:todo_tracker_app/body/record/RecordMemo.dart';

class RecordBody extends StatelessWidget {
  const RecordBody({super.key});

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
