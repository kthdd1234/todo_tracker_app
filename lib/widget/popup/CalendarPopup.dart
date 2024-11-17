import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonPopup.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/final.dart';

class CalendarPopup extends StatelessWidget {
  CalendarPopup({
    super.key,
    required this.view,
    required this.initialdDateTime,
    required this.onSelectionChanged,
  });

  DateRangePickerView view;
  DateTime initialdDateTime;
  Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonPopup(
      insetPaddingHorizontal: 50,
      height: 400,
      child: CommonContainer(
        child: SfDateRangePicker(
          backgroundColor: Colors.transparent,
          headerStyle: DateRangePickerHeaderStyle(
            backgroundColor: Colors.transparent,
            textStyle: TextStyle(
              fontWeight: isLight ? null : FontWeight.bold,
              color: isLight ? Colors.black : Colors.white,
            ),
          ),
          yearCellStyle: DateRangePickerYearCellStyle(
            textStyle: TextStyle(
              color: isLight ? Colors.black : Colors.white,
              fontWeight: isLight ? null : FontWeight.bold,
            ),
          ),
          selectionTextStyle: TextStyle(
            fontWeight: isLight ? FontWeight.bold : null,
            color: isLight ? Colors.white : Colors.black,
          ),
          selectionColor: isLight ? indigo.s200 : Colors.white,
          showNavigationArrow: true,
          initialDisplayDate: initialdDateTime,
          initialSelectedDate: initialdDateTime,
          maxDate: DateTime(3000, 1, 1),
          view: view,
          allowViewNavigation: false,
          onSelectionChanged: onSelectionChanged,
        ),
      ),
    );
  }
}
