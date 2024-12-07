import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_tracker_app/util/func.dart';

class AppBarInfoClass {
  AppBarInfoClass({
    required this.title,
    this.isCenter,
    this.actions,
    this.initFontSize,
    this.isNotTr,
    this.isBold,
    this.color,
  });

  String title;
  bool? isCenter, isNotTr, isBold;
  List<Widget>? actions;
  double? initFontSize;
  Color? color;
}

class BottomNavigationBarClass {
  BottomNavigationBarClass({
    required this.svgAsset,
    required this.index,
    required this.label,
    required this.body,
  });

  String svgAsset, label;
  int index;
  Widget body;
}

class ColorClass {
  ColorClass({
    required this.s50,
    required this.s100,
    required this.s200,
    required this.s300,
    required this.s400,
    required this.original,
    required this.colorName,
  });

  String colorName;
  Color s50, s100, s200, s300, s400, original;
}

class PremiumBenefitClass {
  PremiumBenefitClass({
    required this.svgName,
    required this.mainTitle,
    required this.subTitle,
  });

  String svgName, mainTitle, subTitle;
}

class WidgetHeaderClass {
  final String title, today;
  final List<int> textRGB, bgRGB;

  WidgetHeaderClass(this.title, this.today, this.textRGB, this.bgRGB);

  WidgetHeaderClass.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        today = json['today'] as String,
        textRGB = json['textRGB'] as List<int>,
        bgRGB = json['bgRGB'] as List<int>;

  Map<String, dynamic> toJson() => {
        'title': title,
        'today': today,
        'textRGB': textRGB,
        'bgRGB': bgRGB,
      };
}

class WidgetItemClass {
  // final String id, category, amount;
  // final List<int> amountRGB;

  // WidgetItemClass(
  //   this.id,
  //   this.category,
  //   this.amount,
  //   this.amountRGB,
  // );

  // WidgetItemClass.fromJson(Map<String, dynamic> json)
  //     : id = json['id'] as String,
  //       category = json['category'] as String,
  //       amount = json['amount'] as String,
  //       amountRGB = json['amountRGB'] as List<int>;

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'category': category,
  //       'amount': amount,
  //       'amountRGB': amountRGB,
  //     };
}

class BackgroundClass {
  BackgroundClass({
    required this.path,
    required this.name,
  });

  String path, name;
}

class BNClass {
  BNClass({
    required this.index,
    required this.name,
    required this.icon,
    required this.svgName,
  });

  int index;
  String name, svgName;
  Widget icon;
}

class FadePageRoute extends PageRouteBuilder {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
}

class SettingItemClass {
  SettingItemClass({
    required this.name,
    required this.svg,
    required this.onTap,
    this.value,
  });

  String name, svg;
  Widget? value;
  Function() onTap;
}

class DateTimeInfoClass {
  DateTimeInfoClass({required this.type, required this.dateTimeList});

  String type;
  List<DateTime> dateTimeList;
}

class DateTimeTypeClass {
  DateTimeTypeClass({
    required this.selection,
    required this.everyWeek,
    required this.everyMonth,
  });

  String selection, everyWeek, everyMonth;
}

class GraphData {
  GraphData(this.x, this.y);

  final String x;
  final double? y;
}

class DayColorClass {
  DayColorClass({required this.type, required this.color});

  String type;
  ColorClass color;
}

class TitleInfoClass {
  TitleInfoClass({required this.title, required this.colorName});

  String title, colorName;

  TitleInfoClass.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        colorName = json['colorName'] as String;

  Map<String, dynamic> toJson() => {'title': title, 'colorName': colorName};
}

class WeekDayClass {
  WeekDayClass({
    required this.id,
    required this.name,
    required this.isVisible,
  });

  int id;
  String name;
  bool isVisible;
}

class MonthDayClass {
  MonthDayClass({
    required this.id,
    required this.isVisible,
  });

  int id;
  bool isVisible;
}

class RecordItemClass {
  RecordItemClass({required this.groupInfo, required this.taskInfo});

  GroupInfoClass groupInfo;
  TaskInfoClass taskInfo;
}

class MarkClass {
  MarkClass({
    required this.E,
    required this.O,
    required this.X,
    required this.M,
    required this.T,
  });

  markName(String mark) {
    return {'O': '완료했어요', 'X': '안했어요', 'M': '덜 했어요', 'T': '내일 할래요'}[mark]!;
  }

  String E, O, X, M, T;
}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ firestore data modeling ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

class UserInfoClass {
  UserInfoClass({
    required this.uid,
    required this.loginType,
    required this.osType,
    required this.createDateTime,
    required this.fontFamily,
    required this.background,
    required this.theme,
    required this.appStartIndex,
    required this.titleInfo,
    required this.groupOrderList,
    required this.taskOrderList,
    required this.fontSize,
    this.passwords,
  });

  String uid, loginType, fontFamily, background, theme, osType;
  DateTime createDateTime;
  int appStartIndex;
  TitleInfoClass titleInfo;
  List<String> groupOrderList;
  List<TaskOrderClass> taskOrderList;
  double fontSize;
  String? passwords;

  UserInfoClass.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] as String,
        loginType = json['loginType'] as String,
        osType = json['osType'] as String,
        createDateTime = timestampToDateTime(json['createDateTime']),
        appStartIndex = json['appStartIndex'] as int,
        fontFamily = json['fontFamily'] as String,
        background = json['background'] as String,
        theme = json['theme'] as String,
        titleInfo = TitleInfoClass.fromJson(json['titleInfo']),
        groupOrderList = dynamicToIdList(json['groupOrderList']),
        taskOrderList = taskOrderFromJson(json['taskOrderList']),
        fontSize = json['fontSize'] as double,
        passwords = json['passwords'] as String?;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'loginType': loginType,
        'osType': osType,
        'createDateTime': createDateTime,
        'appStartIndex': appStartIndex,
        'fontFamily': fontFamily,
        'background': background,
        'theme': theme,
        'titleInfo': titleInfo.toJson(),
        'groupOrderList': groupOrderList,
        'taskOrderList': taskOrderToJson(taskOrderList),
        'fontSize': fontSize,
        'passwords': passwords,
      };
}

class GroupInfoClass {
  GroupInfoClass({
    required this.gid,
    required this.name,
    required this.colorName,
    required this.createDateTime,
    required this.isOpen,
    required this.taskInfoList,
  });

  String gid, name, colorName;
  DateTime createDateTime;
  bool isOpen;
  List<TaskInfoClass> taskInfoList;

  GroupInfoClass.fromJson(Map<String, dynamic> json)
      : gid = json['gid'] as String,
        name = json['name'] as String,
        colorName = json['colorName'] as String,
        createDateTime = timestampToDateTime(json['createDateTime']),
        isOpen = json['isOpen'] as bool,
        taskInfoList = taskInfoFromJson(json['taskInfoList']);

  Map<String, dynamic> toJson() => {
        'gid': gid,
        'name': name,
        'colorName': colorName,
        'createDateTime': createDateTime,
        'isOpen': isOpen,
        'taskInfoList': taskInfoToJson(taskInfoList)
      };
}

class TaskInfoClass {
  TaskInfoClass({
    required this.createDateTime,
    required this.tid,
    required this.name,
    required this.dateTimeType,
    required this.dateTimeList,
    required this.recordInfoList,
  });

  DateTime createDateTime;
  String tid, name, dateTimeType;
  List<DateTime> dateTimeList;
  List<RecordInfoClass> recordInfoList;

  TaskInfoClass.fromJson(Map<String, dynamic> json)
      : createDateTime = timestampToDateTime(json['createDateTime']),
        tid = json['tid'] as String,
        name = json['name'] as String,
        dateTimeType = json['dateTimeType'] as String,
        dateTimeList = timestampToDateTimeList(json['dateTimeList']),
        recordInfoList = recordFromJson(json['recordInfoList']);

  Map<String, dynamic> toJson() => {
        'createDateTime': createDateTime,
        'tid': tid,
        'name': name,
        'dateTimeType': dateTimeType,
        'dateTimeList': dateTimeList,
        'recordInfoList': recordToJson(recordInfoList),
      };
}

class TaskOrderClass {
  TaskOrderClass({required this.dateTimeKey, required this.list});

  int dateTimeKey;
  List<String> list;

  TaskOrderClass.fromJson(Map<String, dynamic> json)
      : dateTimeKey = json['dateTimeKey'],
        list = json['list'];

  Map<String, dynamic> toJson() => {
        'dateTimeKey': dateTimeKey,
        'list': list,
      };
}

class RecordInfoClass {
  RecordInfoClass({required this.dateTimeKey, this.memo, this.mark});

  int dateTimeKey;
  String? memo, mark;

  RecordInfoClass.fromJson(Map<String, dynamic> json)
      : dateTimeKey = json['dateTimeKey'] as int,
        memo = json['memo'] as String?,
        mark = json['mark'] as String?;

  Map<String, dynamic> toJson() =>
      {'dateTimeKey': dateTimeKey, 'memo': memo, 'mark': mark};
}

class MemoInfoClass {
  MemoInfoClass({
    required this.dateTimeKey,
    this.path,
    this.imgUrl,
    this.text,
    this.textAlign,
  });

  int dateTimeKey;
  String? path, imgUrl, text;
  TextAlign? textAlign;

  MemoInfoClass.fromJson(Map<String, dynamic> json)
      : dateTimeKey = json['dateTimeKey'] as int,
        path = json['path'] as String?,
        imgUrl = json['imgUrl'] as String?,
        text = json['text'] as String?,
        textAlign = stringToTextAlign(json['textAlign']);

  Map<String, dynamic> toJson() => {
        'dateTimeKey': dateTimeKey,
        'path': path,
        'text': text,
        'imgUrl': imgUrl,
        'textAlign': textAlignToString(textAlign)
      };
}

class StickerClass {
  StickerClass({required this.mark, required this.color});

  String? mark;
  ColorClass color;
}
