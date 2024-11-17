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

class RepeatWeeklyClass {
  RepeatWeeklyClass({
    required this.id,
    required this.name,
    required this.isVisible,
  });

  int id;
  String name;
  bool isVisible;
}

class RepeatMonthlyClass {
  RepeatMonthlyClass({required this.id, required this.isVisible});

  int id;
  bool isVisible;
}

class RecordItemClass {
  // RecordItemClass({
  //   required this.categoryInfo,
  //   required this.recordInfo,
  //   required this.householdInfo,
  // });

  // CategoryInfoClass categoryInfo;
  // RecordInfoClass recordInfo;
  // HouseholdInfoClass householdInfo;
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
    required this.fontSize,
    this.passwords,
  });

  String uid, loginType, fontFamily, background, theme, osType;
  DateTime createDateTime;
  int appStartIndex;
  TitleInfoClass titleInfo;
  List<String> groupOrderList;
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
        'fontSize': fontSize,
        'passwords': passwords,
      };
}
