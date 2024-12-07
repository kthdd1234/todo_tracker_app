import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/final.dart';

class RecordItemMemo extends StatelessWidget {
  RecordItemMemo({super.key, this.memo});

  String? memo;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    return memo != null
        ? Padding(
            padding: const EdgeInsets.only(top: 2),
            child: CommonText(
              text: memo!,
              color: isLight ? grey.original : grey.s400,
              initFontSize: fontSize - 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              isBold: !isLight,
              isNotTr: true,
            ),
          )
        : const CommonNull();
  }
}
