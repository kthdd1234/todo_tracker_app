import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/memo/MemoContainer.dart';
import 'package:todo_tracker_app/widget/memo/MemoImage.dart';

class SearchItemMemo extends StatelessWidget {
  SearchItemMemo({super.key, required this.searchItemMemo});

  SearchItemMemoClass searchItemMemo;

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    MemoInfoClass memoInfo = searchItemMemo.memoInfo;

    String mde = mdeFormatter(
      locale: locale,
      dateTime: searchItemMemo.dateTime,
    );
    String? imgUrl = memoInfo.imgUrl;
    String? text = memoInfo.text;

    return MemoContainer(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(text: mde, color: textColor, initFontSize: fontSize - 1),
          CommonSpace(height: 5),
          imgUrl != null
              ? MemoImage(imageUrl: imgUrl, onTap: () {})
              : const CommonNull(),
          imgUrl != null && text != null
              ? CommonSpace(height: 10)
              : const CommonNull(),
          text != null
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CommonText(
                    text: text,
                    initFontSize: fontSize,
                    textAlign: memoInfo.textAlign ?? TextAlign.left,
                    isBold: !isLight,
                    isNotTr: true,
                  ),
                )
              : const CommonNull()
        ],
      ),
    );
  }
}
