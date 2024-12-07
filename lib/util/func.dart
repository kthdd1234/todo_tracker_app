// ignore_for_file: unused_local_variable, prefer_const_declarations

import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/final.dart';

SvgPicture svgAsset({
  required String name,
  required double width,
  Color? color,
}) {
  return SvgPicture.asset(
    'assets/svgs/$name.svg',
    width: width,
    colorFilter:
        color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
  );
}

String ymdFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMd(locale).format(dateTime);
}

String ymdFullFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMMMMd(locale).format(dateTime);
}

String mdeFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.MMMEd(locale).format(dateTime);
}

String mdFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.MMMd(locale).format(dateTime);
}

String ymdeFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMMMEd(locale).format(dateTime);
}

String ymdeShortFormatter(
    {required String locale, required DateTime dateTime}) {
  return DateFormat.yMEd(locale).format(dateTime);
}

String yMFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMMM(locale).format(dateTime);
}

String yFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.y(locale).format(dateTime);
}

String mFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.M(locale).format(dateTime);
}

String mmmFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.MMM(locale).format(dateTime);
}

String mmmmFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.MMMM(locale).format(dateTime);
}

String dFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.d(locale).format(dateTime);
}

String deFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat(' EEEE').format(dateTime);
}

String eFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.E(locale).format(dateTime);
}

String eeeeFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.EEEE(locale).format(dateTime);
}

String hmFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.jm(locale).format(dateTime);
}

ColorClass getColorClass(String? name) {
  if (name == null) {
    return indigo;
  }

  return colorList.firstWhere((info) => info.colorName == name);
}

void navigatorPop(context) {
  Navigator.of(context, rootNavigator: true).pop('dialog');
}

int ymdToInt(DateTime? dateTime) {
  if (dateTime == null) {
    return 0;
  }

  DateFormat formatter = DateFormat('yyyyMMdd');
  String strDateTime = formatter.format(dateTime);

  return int.parse(strDateTime);
}

int dateTimeKey(DateTime? dateTime) {
  if (dateTime == null) {
    return 0;
  }

  DateFormat formatter = DateFormat('yyyyMMdd');
  String strDateTime = formatter.format(dateTime);

  return int.parse(strDateTime);
}

String uuid() {
  return DateTime.now().microsecondsSinceEpoch.toString();
}

Future<Map<String, dynamic>> getAppInfo() async {
  PackageInfo info = await PackageInfo.fromPlatform();

  return {
    "appVerstion": info.version,
    'appBuildNumber': info.buildNumber,
  };
}

movePage({required BuildContext context, required Widget page}) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (BuildContext context) => page),
  );
}

moveFadePage({required BuildContext context, required Widget page}) {
  FadePageRoute fadePageRoute = FadePageRoute(page: page);
  Navigator.push(context, fadePageRoute);
}

// ad: banner, native, appOpening
String getAdId(String ad) {
  final platform = Platform.isIOS ? 'ios' : 'android';
  final env = kDebugMode ? 'debug' : 'real';
  final adId = {
    'android': {
      'banner': {
        'debug': androidBannerTestId,
        'real': androidBannerRealId,
      },
      'native': {
        'debug': androidNativeTestId,
        'real': androidNativeRealId,
      },
      'appOpening': {
        'debug': androidAppOpeningTestId,
        'real': androidAppOpeningRealId,
      },
      'interstitial': {
        'debug': androidInterstitialTestId,
        'real': androidInterstitialRealId,
      }
    },
    'ios': {
      'banner': {
        'debug': iOSBannerTestId,
        'real': iOSBannerRealId,
      },
      'native': {
        'debug': iOSNativeTestId,
        'real': iOSNativeRealId,
      },
      'appOpening': {
        'debug': iOSAppOpeningTestId,
        'real': iOSAppOpeningRealId,
      },
      'interstitial': {
        'debug': iOSInterstitialTestId,
        'real': iOSInterstitialRealId,
      }
    },
  };

  return adId[platform]![ad]![env]!;
}

Future<bool> setPurchasePremium(Package package) async {
  try {
    CustomerInfo customerInfo = await Purchases.purchasePackage(package);
    return customerInfo.entitlements.all[entitlementIdentifier]?.isActive ==
        true;
  } on PlatformException catch (e) {
    log('e =>> ${e.toString()}');
    return false;
  }
}

// Future<bool> isPurchasePremium() async {
//   try {
//     CustomerInfo customerInfo = await Purchases.getCustomerInfo();
//     bool isActive =
//         customerInfo.entitlements.all[entitlementIdentifier]?.isActive == true;
//     return isActive;
//     // return true;
//   } on PlatformException catch (e) {
//     log('e =>> ${e.toString()}');
//     return false;
//   }
// }

// Future<bool> isPurchaseRestore() async {
//   try {
//     CustomerInfo customerInfo = await Purchases.restorePurchases();
//     bool isActive =
//         customerInfo.entitlements.all[entitlementIdentifier]?.isActive == true;
//     return isActive;
//   } on PlatformException catch (e) {
//     log('e =>> ${e.toString()}');
//     return false;
//   }
// }

// //
// bool isSearchCategory(String? id) {
//   if (id == null) return false;

//   UserBox? user = userRepository.user;
//   List<String> filterList = user.filterIdList ?? [];

//   return filterList.contains(id) == true;
// }

DateTime weeklyStartDateTime(DateTime dateTime) {
  if (dateTime.weekday == 7) {
    return dateTime;
  }

  return dateTime.subtract(Duration(days: dateTime.weekday));
}

DateTime weeklyEndDateTime(DateTime dateTime) {
  if (dateTime.weekday == 7) {
    return dateTime.add(const Duration(days: 6));
  }

  return dateTime.add(Duration(
    days: DateTime.daysPerWeek - dateTime.weekday - 1,
  ));
}

calendarHeaderStyle(bool isLight) {
  return HeaderStyle(
    titleCentered: true,
    titleTextStyle: TextStyle(
      color: isLight ? Colors.black : Colors.white,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    formatButtonVisible: false,
    leftChevronIcon: Icon(
      Icons.chevron_left,
      color: isLight ? buttonColor : Colors.white,
    ),
    rightChevronIcon: Icon(
      Icons.chevron_right,
      color: isLight ? buttonColor : Colors.white,
    ),
  );
}

calendarDaysOfWeekStyle(bool isLight) {
  return DaysOfWeekStyle(
    weekdayStyle: TextStyle(
      fontSize: 13,
      color: isLight ? Colors.black : darkTextColor,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    weekendStyle: TextStyle(
      fontSize: 13,
      color: red.s300,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
  );
}

calendarDetailStyle(bool isLight) {
  return CalendarStyle(
    todayDecoration: const BoxDecoration(color: Colors.transparent),
    todayTextStyle: TextStyle(
      color: isLight ? Colors.black : darkTextColor,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    outsideDaysVisible: false,
  );
}

String getLocaleName(String locale) {
  if (locale == 'ko') {
    return '한국어';
  } else if (locale == 'ja') {
    return '日本語';
  } else {
    return 'English';
  }
}

DateTime timestampToDateTime(timestamp) {
  return DateTime.parse(timestamp.toDate().toString());
}

List<DateTime> timestampToDateTimeList(List<dynamic> timestampList) {
  return timestampList
      .map((timestamp) => timestampToDateTime(timestamp))
      .toList();
}

List<String> dynamicToIdList(List<dynamic> dynamicList) {
  return dynamicList.map((id) => id.toString()).toList();
}

List<Map<String, dynamic>> taskOrderToJson(List<TaskOrderClass> list) {
  return list.map((info) => info.toJson()).toList();
}

List<Map<String, dynamic>> taskInfoToJson(List<TaskInfoClass> list) {
  return list.map((info) => info.toJson()).toList();
}

List<RecordInfoClass> recordFromJson(List<dynamic> list) {
  return list.map((info) => RecordInfoClass.fromJson(info)).toList();
}

List<Map<String, dynamic>> recordToJson(List<RecordInfoClass> list) {
  return list.map((info) => info.toJson()).toList();
}

List<TaskOrderClass> taskOrderFromJson(List<dynamic> list) {
  return list
      .map(
        (info) => TaskOrderClass(
          dateTimeKey: info['dateTimeKey'],
          list: dynamicToIdList(info['list']),
        ),
      )
      .toList();
}

List<TaskInfoClass> taskInfoFromJson(List<dynamic> list) {
  return list
      .map(
        (info) => TaskInfoClass(
          createDateTime: timestampToDateTime(info['createDateTime']),
          tid: info['tid'],
          name: info['name'],
          dateTimeType: info['dateTimeType'],
          dateTimeList: timestampToDateTimeList(info['dateTimeList']),
          recordInfoList: recordFromJson(info['recordInfoList']),
        ),
      )
      .toList();
}

String? textAlignToString(TextAlign? textAlign) {
  Map<TextAlign, String> textAlignToString = {
    TextAlign.left: TextAlign.left.toString(),
    TextAlign.center: TextAlign.center.toString(),
    TextAlign.right: TextAlign.right.toString(),
  };

  return textAlign != null ? textAlignToString[textAlign] : null;
}

TextAlign? stringToTextAlign(String? textAlign) {
  Map<String, TextAlign> stringToTextAlign = {
    TextAlign.left.toString(): TextAlign.left,
    TextAlign.center.toString(): TextAlign.center,
    TextAlign.right.toString(): TextAlign.right,
  };

  return textAlign != null ? stringToTextAlign[textAlign] : null;
}

navigatorRemoveUntil({
  required BuildContext context,
  required Widget page,
}) async {
  FadePageRoute fadePageRoute = FadePageRoute(page: page);
  Navigator.pushAndRemoveUntil(context, fadePageRoute, (_) => false);
}

themeData(String fontFamily) {
  return ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}

List<BNClass> getBnClassList(bool isLight, int seletedIdx) {
  svg(int idx, String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: svgAsset(
        name: name,
        width: idx == 0 ? 23 : 20.5,
        color: idx == seletedIdx
            ? null
            : isLight
                ? grey.original
                : grey.original,
      ),
    );
  }

  List<BNClass> bnClassList = [
    BNClass(
      index: 0,
      name: '홈',
      icon: svg(
        0,
        seletedIdx == 0
            ? 'bnb-home-filled-${isLight ? 'light' : 'dark'}'
            : 'bnb-home',
      ),
      svgName: 'bnb-home',
    ),
    BNClass(
      index: 1,
      name: '캘린더',
      icon: svg(
        1,
        seletedIdx == 1
            ? 'bnb-calendar-filled-${isLight ? 'light' : 'dark'}'
            : 'bnb-calendar',
      ),
      svgName: seletedIdx == 1 ? 'bnb-calendar-filled-light' : 'bnb-calendar',
    ),
    BNClass(
      index: 2,
      name: '표',
      icon: svg(
        2,
        seletedIdx == 2
            ? 'bnb-tracker-filled-${isLight ? 'light' : 'dark'}'
            : 'bnb-tracker',
      ),
      svgName: 'bnb-tracker',
    ),
    BNClass(
      index: 3,
      name: '설정',
      icon: svg(
        3,
        seletedIdx == 3
            ? 'bnb-setting-filled-${isLight ? 'light' : 'dark'}'
            : 'bnb-setting',
      ),
      svgName: 'bnb-setting',
    )
  ];

  return bnClassList;
}

List<BottomNavigationBarItem> getBnbiList(bool isLight, int seletedIdx) {
  List<BottomNavigationBarItem> bnbList = getBnClassList(
    isLight,
    seletedIdx,
  )
      .map(
        (bn) => BottomNavigationBarItem(label: bn.name.tr(), icon: bn.icon),
      )
      .toList();

  return bnbList;
}

String getBnName(int appStartIndex) {
  return ['홈', '캘린더', '체크표'][appStartIndex];
}

errorMessage({required String msg}) {
  Fluttertoast.showToast(
    msg: msg.tr(),
    gravity: ToastGravity.TOP,
    backgroundColor: darkButtonColor,
    fontSize: 12,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
    fontAsset: 'assets/font/IM_Hyemin.ttf',
  );
}

jumpDayDateTime({
  required JumpDayTypeEnum type,
  required DateTime dateTime,
  required int days,
}) {
  Duration duration = Duration(days: days);

  return JumpDayTypeEnum.subtract == type
      ? dateTime.subtract(duration)
      : dateTime.add(duration);
}

showSnackBar({
  required BuildContext context,
  required String text,
  required String buttonName,
  Function()? onPressed,
  double? width,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(text, style: const TextStyle(color: Colors.white)).tr(),
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonName,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ).tr(),
          )
        ],
      ),
      width: width,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}

isContainIdxDateTime({
  required String locale,
  required List<DateTime> selectionList,
  required DateTime targetDateTime,
  String? curDateTimeType,
}) {
  if (curDateTimeType == dateTimeType.selection) {
    String ymd = ymdFormatter(locale: locale, dateTime: targetDateTime);

    return selectionList.indexWhere(
      (dateTime) => ymdFormatter(locale: locale, dateTime: dateTime) == ymd,
    );
  } else if (curDateTimeType == dateTimeType.everyWeek) {
    String e = eFormatter(locale: locale, dateTime: targetDateTime);
    return selectionList.indexWhere(
      (dateTime) => eFormatter(locale: locale, dateTime: dateTime) == e,
    );
  } else {
    DateTime now = DateTime.now();
    String ymd = ymdFormatter(
      locale: locale,
      dateTime: DateTime(
        now.year,
        now.month,
        targetDateTime.day,
      ),
    );

    return selectionList.indexWhere(
      (dateTime) =>
          ymdFormatter(
            locale: locale,
            dateTime: DateTime(now.year, now.month, dateTime.day),
          ) ==
          ymd,
    );
  }
}

String getFontName(String fontFamily) {
  int idx = fontFamilyList
      .indexWhere((element) => element['fontFamily'] == fontFamily);
  return idx != -1 ? fontFamilyList[idx]['name']! : initFontName;
}

bool isEmptyWeekDays(List<WeekDayClass> weekDays) {
  return weekDays.any((weekDay) => weekDay.isVisible) == false;
}

bool isEmptyMonthDays(List<MonthDayClass> monthDays) {
  return monthDays.any((monthDay) => monthDay.isVisible) == false;
}

Future<Uint8List> getCacheData(String url) async {
  File file = await DefaultCacheManager().getSingleFile(url);
  return file.readAsBytes();
}

Future<void> removeImage({required String imgUrl, required String path}) async {
  await DefaultCacheManager().removeFile(imgUrl);
  // await storageRef.child(path).delete();
}

Future<String?> getDownloadUrl(String imgUrl) async {
  // try {
  //   Reference imgRef = storageRef.child(imgUrl);
  //   return await imgRef.getDownloadURL();
  // } catch (e) {
  //   log('$e');
  //   return null;
  // }
}

String getImagePath(String mid) {
  // String uid = auth.currentUser!.uid;
  String uid = '';

  return '$uid/$mid/img.jpg';
}

String getGroupName(String locale) {
  return {
    'ko': '할 일 리스트',
    'en': 'Todo List',
    'ja': 'やることリスト',
  }[locale]!;
}

List<GroupInfoClass> getGroupInfoOrderList(
  List<String> groupOrderList,
  List<GroupInfoClass> groupInfoList,
) {
  groupInfoList.sort((groupA, groupB) {
    int indexA = groupOrderList.indexOf(groupA.gid);
    int indexB = groupOrderList.indexOf(groupB.gid);

    return indexA.compareTo(indexB);
  });

  return groupInfoList;
}

List<RecordItemClass> getRecordItemList({
  required String locale,
  required DateTime targetDateTime,
  required List<GroupInfoClass> groupInfoList,
  required List<TaskOrderClass> taskOrderList,
}) {
  List<RecordItemClass> recordItemList = [];

  for (final groupInfo in groupInfoList) {
    List<TaskInfoClass> taskFilterList = groupInfo.taskInfoList.where((task) {
      String cDateTimeType = task.dateTimeType;
      List<DateTime> cDateTimeList = task.dateTimeList;

      if (cDateTimeType == dateTimeType.selection) {
        return cDateTimeList.any(
          (dateTime) => dateTimeKey(dateTime) == dateTimeKey(targetDateTime),
        );
      } else {
        return cDateTimeList.any((dateTime) {
          if (cDateTimeType == dateTimeType.everyWeek) {
            return eFormatter(locale: locale, dateTime: dateTime) ==
                eFormatter(locale: locale, dateTime: targetDateTime);
          } else if (cDateTimeType == dateTimeType.everyMonth) {
            return dateTime.day == targetDateTime.day;
          }

          return false;
        });
      }
    }).toList();

    for (final taskInfo in taskFilterList) {
      recordItemList.add(
        RecordItemClass(groupInfo: groupInfo, taskInfo: taskInfo),
      );
    }

    int index = taskOrderList.indexWhere(
      (taskOrder) => taskOrder.dateTimeKey == dateTimeKey(targetDateTime),
    );
    List<String> taskOrderIdList = index != -1 ? taskOrderList[index].list : [];

    if (taskOrderIdList.isNotEmpty) {
      recordItemList.sort((itemA, itemB) {
        int indexA = taskOrderIdList.indexOf(itemA.taskInfo.tid);
        int indexB = taskOrderIdList.indexOf(itemB.taskInfo.tid);

        indexA = indexA == -1 ? 999999 : indexA;
        indexB = indexB == -1 ? 999999 : indexB;

        return indexA.compareTo(indexB);
      });
    } else {
      recordItemList.sort((itemA, itemB) {
        int ts1 = itemA.taskInfo.createDateTime.microsecondsSinceEpoch;
        int ts2 = itemB.taskInfo.createDateTime.microsecondsSinceEpoch;

        ts1 = ts1 == -1 ? 999999 : ts1;
        ts2 = ts2 == -1 ? 999999 : ts2;

        return ts1.compareTo(ts2);
      });
    }
  }

  return recordItemList;
}

int getRecordIndex({
  required List<RecordInfoClass> recordInfoList,
  required DateTime targetDateTime,
}) {
  return recordInfoList.indexWhere(
    (recordInfo) => recordInfo.dateTimeKey == dateTimeKey(targetDateTime),
  );
}

RecordInfoClass? getRecordInfo({
  required List<RecordInfoClass> recordInfoList,
  required DateTime targetDateTime,
}) {
  int index = getRecordIndex(
    recordInfoList: recordInfoList,
    targetDateTime: targetDateTime,
  );

  return index != -1 ? recordInfoList[index] : null;
}
