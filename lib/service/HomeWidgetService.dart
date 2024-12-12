import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/func.dart';

class HomeWidgetService {
  Future<bool?> updateWidget({
    required Map<String, String> data,
    required String widgetName,
  }) async {
    data.forEach((key, value) async {
      await HomeWidget.saveWidgetData<String>(key, value);
    });

    return await HomeWidget.updateWidget(iOSName: widgetName);
  }

  updateData({
    required String locale,
    required UserInfoClass userInfo,
    required List<GroupInfoClass> groupInfoList,
  }) {
    DateTime now = DateTime.now();
    String fontFamily = userInfo.fontFamily;
    String widgetTheme = userInfo.theme;
    bool isWidgetLight = userInfo.theme == 'light';
    List<TaskOrderClass> taskOrderList = userInfo.taskOrderList;
    String titleName = userInfo.titleInfo.title;
    ColorClass titleColor = getColorClass(userInfo.titleInfo.colorName);
    List<RecordItemClass> recordItemList = getRecordItemList(
      locale: locale,
      targetDateTime: now,
      groupInfoList: groupInfoList,
      taskOrderList: taskOrderList,
    );

    List<WidgetItemClass> widgetItemList = [];

    for (var recordItem in recordItemList) {
      GroupInfoClass groupInfo = recordItem.groupInfo;
      TaskInfoClass taskInfo = recordItem.taskInfo;
      ColorClass color = getColorClass(groupInfo.colorName);

      // widget colors
      Color barColor = isWidgetLight ? color.s100 : color.s400;
      Color lineColor = isWidgetLight ? color.s300 : color.s200;
      Color markColor = isWidgetLight ? color.s200 : color.s300;
      Color highlightColor = isWidgetLight ? color.s50 : color.s400;

      String mark = getRecordInfo(
            recordInfoList: taskInfo.recordInfoList,
            targetDateTime: now,
          )?.mark ??
          'E';

      List<int> barRGB = [barColor.red, barColor.green, barColor.blue];
      List<int> lineRGB = [lineColor.red, lineColor.green, lineColor.blue];
      List<int> markRGB = [markColor.red, markColor.green, markColor.blue];
      List<int>? highlightRGB = mark != 'E'
          ? [highlightColor.red, highlightColor.green, highlightColor.blue]
          : null;

      WidgetItemClass widgetItem = WidgetItemClass(
        taskInfo.tid,
        taskInfo.name,
        mark,
        barRGB,
        lineRGB,
        markRGB,
        highlightRGB,
      );

      widgetItemList.add(widgetItem);
    }

    Color titleTextColor = isWidgetLight ? titleColor.s400 : titleColor.s200;
    Color titleBgColor =
        isWidgetLight ? titleColor.s50.withOpacity(0.5) : darkButtonColor;
    String mde = mdeFormatter(locale: locale, dateTime: now);

    WidgetHeaderClass widgetHeader = WidgetHeaderClass(
      titleName,
      mde,
      [titleTextColor.red, titleTextColor.green, titleTextColor.blue],
      [titleBgColor.red, titleBgColor.green, titleBgColor.blue],
    );

    Map<String, String> entry = {
      "fontFamily": fontFamily,
      "emptyText": "추가된 할 일이 없어요",
      "header": jsonEncode(widgetHeader),
      "taskList": jsonEncode(widgetItemList),
      "widgetTheme": widgetTheme,
    };

    return updateWidget(data: entry, widgetName: 'TodoWidget');
  }
}
