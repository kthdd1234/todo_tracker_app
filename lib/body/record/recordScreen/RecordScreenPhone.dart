import 'package:flutter/cupertino.dart';
import 'package:todo_tracker_app/body/record/RecordAppBar.dart';
import 'package:todo_tracker_app/body/record/RecordCalendar.dart';
import 'package:todo_tracker_app/body/record/RecordContainer.dart';
import 'package:todo_tracker_app/body/record/RecordMemo.dart';

class RecordScreenPhone extends StatelessWidget {
  RecordScreenPhone({super.key, required this.onHorizontalDragEnd});

  Function(DragEndDetails) onHorizontalDragEnd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: onHorizontalDragEnd,
      child: Column(
        children: [
          RecordAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [RecordCalendar(), RecordMemo(), RecordContainer()],
              ),
            ),
          )
        ],
      ),
    );
  }
}
