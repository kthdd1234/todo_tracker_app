import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonSvgText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/enum.dart';

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
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: CommonSvgText(
        text: title,
        initFontSize: fontSize + 4,
        isNotTr: true,
        textColor: isLight ? darkButtonColor : Colors.white,
        svgWidth: 6,
        svgLeft: 3,
        svgName: 'dir-right-s',
        svgColor: isLight ? darkButtonColor : Colors.white,
        svgDirection: SvgDirectionEnum.right,
        onTap: onTitle,
      ),
    );
  }
}
