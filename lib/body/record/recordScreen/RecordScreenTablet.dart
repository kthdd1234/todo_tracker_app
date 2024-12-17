import 'package:flutter/cupertino.dart';
import 'package:todo_tracker_app/body/record/RecordAppBar.dart';
import 'package:todo_tracker_app/body/record/RecordCalendar.dart';
import 'package:todo_tracker_app/body/record/RecordContainer.dart';
import 'package:todo_tracker_app/body/record/RecordMemo.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';

class RecordScreenTablet extends StatelessWidget {
  RecordScreenTablet({super.key, required this.onHorizontalDragEnd});

  Function(DragEndDetails) onHorizontalDragEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RecordAppBar(),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child:
                      Column(children: [const RecordCalendar(), RecordMemo()]),
                ),
              ),
              CommonSpace(width: 15),
              const Expanded(
                  child: SingleChildScrollView(child: RecordContainer()))
            ],
          ),
        ),
      ],
    );
  }
}
