import 'package:flutter/cupertino.dart';
import 'package:todo_tracker_app/body/record/RecordMemo.dart';

class CalendarMemo extends StatelessWidget {
  CalendarMemo({super.key});

  @override
  Widget build(BuildContext context) {
    return RecordMemo(isCalendar: true);
  }
}
