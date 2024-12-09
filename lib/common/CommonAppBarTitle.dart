import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/TitleDateTimeProvider.dart';
import 'package:todo_tracker_app/util/func.dart';

class CommonAppBarTitle extends StatelessWidget {
  CommonAppBarTitle({
    super.key,
    required this.title,
    required this.onTitle,
  });

  String title;
  Function() onTitle;

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    DateTime titleDateTime =
        context.watch<TitleDateTimeProvider>().titleDateTime;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: CommonText(
        text: yMFormatter(locale: locale, dateTime: titleDateTime),
        initFontSize: fontSize + 3,
        onTap: onTitle,
        isNotTr: true,
      ),
    );
  }
}

// CommonSvgText(
//         text: yMFormatter(locale: locale, dateTime: titleDateTime),
//         initFontSize: fontSize + 4,
//         isNotTr: true,
//         textColor: isLight ? darkButtonColor : Colors.white,
//         svgWidth: 16,
//         svgLeft: 0,
//         svgName: 'expand',
//         svgColor: isLight ? darkButtonColor : Colors.white,
//         svgDirection: SvgDirectionEnum.right,
//         onTap: onTitle,
//       ),