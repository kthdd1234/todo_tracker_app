import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonAppBarTitle.dart';
import 'package:todo_tracker_app/common/CommonSegmented.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class SearchAppBar extends StatelessWidget {
  SearchAppBar({
    super.key,
    required this.titleDateTime,
    required this.selectedSegment,
    required this.onSegmentedChanged,
    required this.onTitleDateTime,
  });

  DateTime titleDateTime;
  SegmentedTypeEnum selectedSegment;
  Function(SegmentedTypeEnum?) onSegmentedChanged;
  Function() onTitleDateTime;

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    bool isTodo = selectedSegment == SegmentedTypeEnum.todo;
    ColorClass color = isTodo ? indigo : orange;
    String title = yMFormatter(locale: locale, dateTime: titleDateTime);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CommonAppBarTitle(title: title, onTitle: onTitleDateTime),
          const Spacer(),
          SizedBox(
            width: locale == 'ko' ? 120 : 150,
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
