import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';

final indigo = ColorClass(
  colorName: '남색',
  original: Colors.indigo, // 63, 81, 181
  s50: Colors.indigo.shade50, // 232, 234, 246
  s100: Colors.indigo.shade100, // 197, 202, 233
  s200: Colors.indigo.shade200, // 159, 168, 218
  s300: Colors.indigo.shade300, // 121, 134, 203
  s400: Colors.indigo.shade400, // 92, 107, 192
);

final green = ColorClass(
  colorName: '녹색',
  original: Colors.green,
  s50: Colors.green.shade50,
  s100: Colors.green.shade100,
  s200: Colors.green.shade200, // 165, 214, 167
  s300: Colors.green.shade300,
  s400: Colors.green.shade400,
); //

final teal = ColorClass(
  colorName: '청록색',
  original: Colors.teal,
  s50: Colors.teal.shade50,
  s100: Colors.teal.shade100, // 178, 223, 219
  s200: Colors.teal.shade200, // 128, 203, 196
  s300: Colors.teal.shade300, // 255, 77, 182, 172
  s400: Colors.teal.shade400,
); //

final red = ColorClass(
  colorName: '빨간색',
  original: Colors.red,
  s50: Colors.red.shade50,
  s100: Colors.red.shade100, // 255, 205, 210
  s200: Colors.red.shade200, // 239, 154, 154
  s300: Colors.red.shade300, // 229, 115, 115
  s400: Colors.red.shade400,
); //

final pink = ColorClass(
  colorName: '핑크색',
  original: Colors.pink,
  s50: Colors.pink.shade50,
  s100: Colors.pink.shade100,
  s200: Colors.pink.shade200,
  s300: Colors.pink.shade300,
  s400: Colors.pink.shade400,
); //

final blue = ColorClass(
  colorName: '파란색',
  original: Colors.blue, // 33, 150, 243
  s50: Colors.blue.shade50, // 227, 242, 253
  s100: Colors.blue.shade100, // 187, 222, 251
  s200: Colors.blue.shade200, // 144, 202, 249
  s300: Colors.blue.shade300, // 100, 181, 246
  s400: Colors.blue.shade400, // 66, 165, 245
); //

final brown = ColorClass(
  colorName: '갈색',
  original: Colors.brown,
  s50: Colors.brown.shade50, //
  s100: Colors.brown.shade100,
  s200: Colors.brown.shade200,
  s300: Colors.brown.shade300,
  s400: Colors.brown.shade400,
); //

final orange = ColorClass(
  colorName: '주황색',
  original: Colors.orange,
  s50: Colors.orange.shade50,
  s100: Colors.orange.shade100, // 255, 224, 178
  s200: Colors.orange.shade200, // 255, 204, 128
  s300: Colors.orange.shade300,
  s400: Colors.orange.shade400,
); //

final purple = ColorClass(
  colorName: '보라색',
  original: Colors.purple,
  s50: Colors.purple.shade50,
  s100: Colors.purple.shade100, // 225, 190, 231
  s200: Colors.purple.shade200, // 206, 147, 216
  s300: Colors.purple.shade300, // 186, 104, 200
  s400: Colors.purple.shade400,
); //

final grey = ColorClass(
  colorName: '회색',
  original: Colors.grey.shade600,
  s50: Colors.grey.shade50,
  s100: Colors.grey.shade100,
  s200: Colors.grey.shade200,
  s300: Colors.grey.shade300,
  s400: Colors.grey.shade400,
); //

final lime = ColorClass(
  colorName: '라임색',
  original: Colors.lime,
  s50: Colors.lime.shade50,
  s100: Colors.lime.shade100,
  s200: Colors.lime.shade200,
  s300: Colors.lime.shade300,
  s400: Colors.lime.shade400,
); //

final cyan = ColorClass(
  colorName: '민트색',
  original: Colors.cyan,
  s50: Colors.cyan.shade50,
  s100: Colors.cyan.shade100,
  s200: Colors.cyan.shade200, // 128, 222, 234
  s300: Colors.cyan.shade300,
  s400: Colors.cyan.shade400, // 38, 198, 218
); //

final ember = ColorClass(
  colorName: '노랑색',
  original: Colors.amber,
  s50: Colors.amber.shade50,
  s100: Colors.amber.shade100,
  s200: Colors.amber.shade200,
  s300: Colors.amber.shade300,
  s400: Colors.amber.shade400,
); //

final blueGrey = ColorClass(
  colorName: '청회색',
  original: Colors.blueGrey,
  s50: Colors.blueGrey.shade50,
  s100: Colors.blueGrey.shade100, // 207, 216, 200
  s200: Colors.blueGrey.shade200, // 176, 190, 197
  s300: Colors.blueGrey.shade300,
  s400: Colors.blueGrey.shade400,
); //

final lightBlue = ColorClass(
  colorName: 'lightBlue',
  original: Colors.lightBlue,
  s50: Colors.lightBlue.shade50,
  s100: Colors.lightBlue.shade100,
  s200: Colors.lightBlue.shade200,
  s300: Colors.lightBlue.shade300,
  s400: Colors.lightBlue.shade400,
);

final colorList = [
  indigo,
  red,
  pink,
  green,
  teal,
  blue,
  brown,
  orange,
  purple,
  blueGrey
];

final calendarFormatInfo = {
  CalendarFormat.week.toString(): CalendarFormat.week,
  CalendarFormat.twoWeeks.toString(): CalendarFormat.month,
  CalendarFormat.month.toString(): CalendarFormat.month,
};

final availableCalendarFormats = {
  CalendarFormat.week: 'week',
  CalendarFormat.twoWeeks: 'twoWeeks',
  CalendarFormat.month: 'month',
};

const nextCalendarFormats = {
  CalendarFormat.week: CalendarFormat.twoWeeks,
  CalendarFormat.twoWeeks: CalendarFormat.month,
  CalendarFormat.month: CalendarFormat.week
};

final daysInfo = {
  '일': 7,
  '월': 1,
  '화': 2,
  '수': 3,
  '목': 4,
  '금': 5,
  '토': 6,
  0: 7,
  1: 1,
  2: 2,
  3: 3,
  4: 4,
  5: 5,
  6: 6,
};

final backroundClassList = [
  [
    BackgroundClass(path: '0', name: 'Defalut'),
    BackgroundClass(path: '05', name: 'Paper Texture'),
  ],
  [
    BackgroundClass(path: '1', name: 'Cloudy Apple'),
    BackgroundClass(path: '2', name: 'Snow Again'),
  ],
  [
    BackgroundClass(path: '3', name: 'Pastel Sky'),
    BackgroundClass(path: '4', name: 'Winter Sky'),
  ],
  [
    BackgroundClass(path: '5', name: 'Perfect White'),
    BackgroundClass(path: '6', name: 'Kind Steel'),
  ],
];

final languageList = [
  {'svgName': 'Korea', 'lang': 'ko', 'name': '한국어'},
  {'svgName': 'Usa', 'lang': 'en', 'name': 'English'},
  {'svgName': 'Japan', 'lang': 'ja', 'name': '日本語'},
];

Map<TextAlign, TextAlign> nextTextAlign = {
  TextAlign.left: TextAlign.center,
  TextAlign.center: TextAlign.right,
  TextAlign.right: TextAlign.left
};

Map<TextAlign, String> textAlignName = {
  TextAlign.left: 'left',
  TextAlign.center: 'center',
  TextAlign.right: 'right'
};

Map<String, Map<String, dynamic>> authButtonInfo = {
  'kakao': {
    'svg': 'kakao-logo',
    'name': '카카오 계정',
    'textColor': kakaoTextColor,
    'bgColor': kakaoBgColor,
  },
  'google': {
    'svg': 'google-logo',
    'name': '구글 계정',
    'textColor': darkButtonColor,
    'bgColor': Colors.white,
  },
  'apple': {
    'svg': 'apple-logo',
    'name': '애플 계정',
    'textColor': Colors.white,
    'bgColor': darkButtonColor,
  },
};

bool get isTablet {
  final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
  final logicalShortestSide =
      firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
  return logicalShortestSide > 600;
}

final dateTimeType = DateTimeTypeClass(
  selection: 'selection',
  everyWeek: 'everyWeek',
  everyMonth: 'everyMonth',
);

final dateTimeLabel = {
  'selection': '선택',
  'everyWeek': '매주',
  'everyMonth': '매달',
};

List<DayColorClass> dayColors = [
  DayColorClass(type: "월", color: orange),
  DayColorClass(type: "화", color: cyan),
  DayColorClass(type: "수", color: green),
  DayColorClass(type: "목", color: blueGrey),
  DayColorClass(type: "금", color: indigo),
  DayColorClass(type: "토", color: purple),
  DayColorClass(type: "일", color: brown),
];

List<Map<String, String>> fontFamilyList = [
  {
    "fontFamily": "Omyu",
    "name": "오뮤 다예쁨체",
  },
  {
    "fontFamily": "OpenSans",
    "name": "OpenSans",
  },
  {
    "fontFamily": "Hyemin",
    "name": "IM 혜민",
  },
  {
    "fontFamily": "Kyobo",
    "name": "교보 손글씨",
  },
  {
    "fontFamily": "SingleDay",
    "name": "싱글데이",
  },
  {
    "fontFamily": "Dongdong",
    "name": "카페24 동동",
  },
];

final initUserInfo = UserInfoClass(
  uid: '-',
  loginType: 'None',
  osType: 'None',
  createDateTime: DateTime.now(),
  appStartIndex: 0,
  fontFamily: initFontFamily,
  background: '0',
  theme: 'light',
  titleInfo: TitleInfoClass(title: '할 일 리스트', colorName: '남색'),
  fontSize: defaultFontSize,
  groupOrderList: [],
  taskOrderList: [],
);

final markInfo = MarkClass(
  E: 'E',
  O: 'O',
  X: 'X',
  M: 'M',
  T: 'T',
);

final selectionMarkList = [
  {'mark': markInfo.O, 'name': markInfo.markName(markInfo.O)},
  {'mark': markInfo.X, 'name': markInfo.markName(markInfo.X)},
  {'mark': markInfo.M, 'name': markInfo.markName(markInfo.M)},
  {'mark': markInfo.T, 'name': markInfo.markName(markInfo.T)},
];

final weekMonthMarkList = [
  {'mark': markInfo.O, 'name': markInfo.markName(markInfo.O)},
  {'mark': markInfo.X, 'name': markInfo.markName(markInfo.X)},
  {'mark': markInfo.M, 'name': markInfo.markName(markInfo.M)},
];
