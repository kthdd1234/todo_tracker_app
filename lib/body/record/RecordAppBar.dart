import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/common/CommonAppBarTitle.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/page/GroupPage.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/TitleDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/popup/CalendarPopup.dart';

class RecordAppBar extends StatefulWidget {
  RecordAppBar({super.key});

  @override
  State<RecordAppBar> createState() => _RecordAppBarState();
}

class _RecordAppBarState extends State<RecordAppBar> {
  onGroupPage() {
    movePage(context: context, page: const GroupPage());
  }

  onHorizontalDragEnd(
    DragEndDetails dragEndDetails,
    DateTime selectedDateTime,
  ) {
    double? primaryVelocity = dragEndDetails.primaryVelocity;

    if (primaryVelocity == null) {
      return;
    } else if (primaryVelocity > 0) {
      selectedDateTime = selectedDateTime.subtract(const Duration(days: 1));
    } else if (primaryVelocity < 0) {
      selectedDateTime = selectedDateTime.add(const Duration(days: 1));
    }

    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: selectedDateTime);
    context
        .read<TitleDateTimeProvider>()
        .changeTitleDateTime(dateTime: selectedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;
    DateTime titleDateTime =
        context.watch<TitleDateTimeProvider>().titleDateTime;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;

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

    onAction({
      required String svg,
      required double width,
      required double right,
      required Function() onTap,
    }) {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(
            left: 5,
            bottom: 5,
            top: 5,
            right: right,
          ),
          child: svgAsset(
            name: svg,
            width: width,
            color: isLight ? darkButtonColor : Colors.white,
          ),
        ),
      );
    }

    onFormatChanged() async {
      CalendarFormat calendarFormat =
          calendarFormatInfo[userInfo.calendarFormat]!;
      userInfo.calendarFormat = nextCalendarFormats[calendarFormat].toString();

      await userMethod.updateUser(userInfo: userInfo);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          CommonAppBarTitle(
            title: yMFormatter(locale: locale, dateTime: titleDateTime),
            onTitle: onTitleDateTime,
          ),
          const Spacer(),
          onAction(
            svg: calendarFormatSvg[userInfo.calendarFormat]!,
            width: 18.5,
            right: 7,
            onTap: onFormatChanged,
          ),
          onAction(
            svg: 'list-add',
            right: 5,
            width: 16,
            onTap: onGroupPage,
          ),
        ],
      ),
    );
  }
}
