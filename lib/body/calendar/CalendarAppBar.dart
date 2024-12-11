import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonAppBarTitle.dart';
import 'package:todo_tracker_app/common/CommonSegmented.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class CalendarAppBar extends StatelessWidget {
  CalendarAppBar({
    super.key,
    required this.titleDateTime,
    required this.selectedSegment,
    required this.onTitleDateTime,
    required this.onSegmentedChanged,
  });

  DateTime titleDateTime;
  SegmentedTypeEnum selectedSegment;
  Function() onTitleDateTime;
  Function(SegmentedTypeEnum?) onSegmentedChanged;

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    String title = yMFormatter(locale: locale, dateTime: titleDateTime);
    bool isTodo = selectedSegment == SegmentedTypeEnum.todo;
    ColorClass color = isTodo ? indigo : orange;

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
