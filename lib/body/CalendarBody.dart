import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_tracker_app/body/calendar/CalendarAppBar.dart';
import 'package:todo_tracker_app/body/calendar/CalendarView.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/popup/CalendarPopup.dart';

class CalendarBody extends StatefulWidget {
  const CalendarBody({super.key});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  DateTime titleDateTime = DateTime.now();
  DateTime selectedDateTime = DateTime.now();
  SegmentedTypeEnum selectedSegment = SegmentedTypeEnum.todo;

  onTitleDateTime() {
    showDialog(
      context: context,
      builder: (context) => CalendarPopup(
        view: DateRangePickerView.year,
        initialdDateTime: titleDateTime,
        onSelectionChanged: (args) async {
          setState(() => titleDateTime = args.value);
          navigatorPop(context);
        },
      ),
    );
  }

  onSegmentedChanged(type) {
    setState(() => selectedSegment = type!);
  }

  onPageChanged(dateTime) {
    setState(() => titleDateTime = dateTime);
  }

  onDaySelected(dateTime) {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarAppBar(
          titleDateTime: titleDateTime,
          selectedSegment: selectedSegment,
          onTitleDateTime: onTitleDateTime,
          onSegmentedChanged: onSegmentedChanged,
        ),
        CalendarView(
          selectedDateTime: titleDateTime,
          selectedSegment: selectedSegment,
          onPageChanged: onPageChanged,
          onDaySelected: onDaySelected,
        )
      ],
    );
  }
}
