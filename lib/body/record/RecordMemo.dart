import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/MemoInfoListProvider.dart';
import 'package:todo_tracker_app/provider/PremiumProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/memo/MemoContainer.dart';
import 'package:todo_tracker_app/widget/memo/MemoImage.dart';

class RecordMemo extends StatelessWidget {
  const RecordMemo({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().selectedDateTime;
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    List<MemoInfoClass> memoInfoList =
        context.watch<MemoInfoListProvider>().memoInfoList;

    int index = memoInfoList.indexWhere(
      (memoInfo) => memoInfo.dateTimeKey == dateTimeKey(selectedDateTime),
    );
    MemoInfoClass? memoInfo = index != -1 ? memoInfoList[index] : null;

    onMemo() {
      //
    }

    log('${memoInfo?.imgUrl}');

    return MemoContainer(
      onTap: onMemo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          memoInfo?.imgUrl != null
              ? MemoImage(
                  imageUrl: memoInfo?.imgUrl,
                  onTap: onMemo,
                )
              : const CommonNull(),
          memoInfo?.imgUrl != null && memoInfo?.text != null
              ? CommonSpace(height: 10)
              : const CommonNull(),
          memoInfo?.text != null
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CommonText(
                    text: memoInfo!.text!,
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
