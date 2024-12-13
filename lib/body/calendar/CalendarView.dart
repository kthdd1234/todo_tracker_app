import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/body/calendar/CalendarBar.dart';
import 'package:todo_tracker_app/common/CommonCachedNetworkImage.dart';
import 'package:todo_tracker_app/common/CommonCalendar.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/MemoInfoListProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/TitleDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class CalendarView extends StatelessWidget {
  CalendarView({super.key, required this.selectedSegment});

  SegmentedTypeEnum selectedSegment;

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;
    List<MemoInfoClass> memoInfoList =
        context.watch<MemoInfoListProvider>().memoInfoList;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().selectedDateTime;

    bool isTodo = selectedSegment == SegmentedTypeEnum.todo;

    Widget? barBuilder(bool isLight, DateTime dateTime) {
      List<RecordItemClass> recordItemList = getRecordItemList(
        locale: locale,
        targetDateTime: dateTime,
        groupInfoList: groupInfoList,
        taskOrderList: userInfo.taskOrderList,
      );

      return recordItemList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 40, right: 5, left: 5),
              child: Container(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: recordItemList
                        .map(
                          (recordItem) => CalendarBar(
                            recordItem: recordItem,
                            dateTime: dateTime,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            )
          : const CommonNull();
    }

    Widget? memoBuilder(bool isLight, DateTime dateTime) {
      int index = memoInfoList.indexWhere(
        (memoInfo) => memoInfo.dateTimeKey == dateTimeKey(dateTime),
      );
      MemoInfoClass? memoInfo = index != -1 ? memoInfoList[index] : null;
      bool isPortrait =
          MediaQuery.of(context).orientation == Orientation.portrait;

      return Column(
        children: [
          memoInfo?.imgUrl != null
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    bottom: 3,
                    left: 5,
                    right: 5,
                  ),
                  child: Center(
                    child: CommonCachedNetworkImage(
                      cacheKey: memoInfo!.imgUrl!,
                      imageUrl: memoInfo.imgUrl!,
                      radious: 3,
                      width: double.infinity,
                      height: isTablet
                          ? isPortrait
                              ? 100
                              : 55
                          : 50,
                      onTap: () {},
                    ),
                  ),
                )
              : const CommonNull(),
          CommonSpace(height: memoInfo?.imgUrl == null ? 40 : 0),
          memoInfo?.text != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isLight ? orange.s50 : orange.s300,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: svgAsset(
                        name: 'pencil',
                        width: isTablet ? 12 : 8,
                        color: isLight ? orange.original : orange.s50,
                      ),
                    ),
                  ),
                )
              : const CommonNull()
        ],
      );
    }

    Widget? todayBuilder(isLight, dateTime) {
      Color bgColor = isLight ? indigo.s300 : Colors.white;
      Color textColor = isLight ? Colors.white : darkButtonColor;

      return Column(
        children: [
          CommonSpace(height: 12),
          CircleAvatar(
            radius: 13,
            backgroundColor: bgColor,
            child: CommonText(
              color: textColor,
              text: '${dateTime.day}',
              isNotTr: true,
            ),
          ),
        ],
      );
    }

    onPageChanged(DateTime dateTime) {
      context
          .read<TitleDateTimeProvider>()
          .changeTitleDateTime(dateTime: dateTime);
    }

    onDaySelected(DateTime dateTime) {
      context
          .read<TitleDateTimeProvider>()
          .changeTitleDateTime(dateTime: dateTime);

      context
          .read<SelectedDateTimeProvider>()
          .changeSelectedDateTime(dateTime: dateTime);
    }

    return CommonCalendar(
      selectedDateTime: selectedDateTime,
      calendarFormat: CalendarFormat.month,
      shouldFillViewport: true,
      markerBuilder: isTodo ? barBuilder : memoBuilder,
      todayBuilder: todayBuilder,
      outsideDaysVisible: false,
      initFontSize: fontSize,
      onPageChanged: onPageChanged,
      onDaySelected: onDaySelected,
      onFormatChanged: (_) {},
    );
  }
}
