import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_tracker_app/common/CommonAppBarTitle.dart';
import 'package:todo_tracker_app/common/CommonSegmented.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/TitleDateTimeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/popup/CalendarPopup.dart';

class CalendarAppBar extends StatelessWidget {
  CalendarAppBar({
    super.key,
    required this.selectedSegment,
    required this.onSegmentedChanged,
  });

  SegmentedTypeEnum selectedSegment;
  Function(SegmentedTypeEnum?) onSegmentedChanged;

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    DateTime titleDateTime =
        context.watch<TitleDateTimeProvider>().titleDateTime;

    String title = yMFormatter(locale: locale, dateTime: titleDateTime);
    bool isTodo = selectedSegment == SegmentedTypeEnum.todo;
    ColorClass color = isTodo ? indigo : orange;

    onTitleDateTime() {
      showDialog(
        context: context,
        builder: (context) => CalendarPopup(
          view: DateRangePickerView.year,
          initialdDateTime: titleDateTime,
          onSelectionChanged: (args) async {
            context
                .read<TitleDateTimeProvider>()
                .changeTitleDateTime(dateTime: args.value);
            context
                .read<SelectedDateTimeProvider>()
                .changeSelectedDateTime(dateTime: args.value);

            navigatorPop(context);
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CommonAppBarTitle(title: title, onTitle: onTitleDateTime),
          const Spacer(),
          SizedBox(
            width: 120,
            child: CommonSegmented(
              selectedSegment: selectedSegment,
              thumbColor: color.s50,
              children: segmentedChildren(
                selectedSegment,
                isLight,
                color,
                fontSize,
              ),
              onSegmentedChanged: onSegmentedChanged,
            ),
          )
        ],
      ),
    );
  }
}
