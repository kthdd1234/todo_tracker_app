import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/page/HomePage.dart';
import 'package:todo_tracker_app/provider/MemoInfoListProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class RecordCalendarMemo extends StatelessWidget {
  const RecordCalendarMemo({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    List<MemoInfoClass> memoInfoList =
        context.watch<MemoInfoListProvider>().memoInfoList;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().selectedDateTime;
    int index = memoInfoList.indexWhere(
      (memoInfo) => memoInfo.dateTimeKey == dateTimeKey(selectedDateTime),
    );
    MemoInfoClass? memoInfo = index != -1 ? memoInfoList[index] : null;
    bool isMemo = (memoInfo?.imgUrl != null) || (memoInfo?.text != null);

    return isMemo
        ? Container(
            width: 21,
            height: 3,
            decoration: BoxDecoration(
              color: isLight ? orange.s200 : orange.s300,
              borderRadius: BorderRadius.circular(3),
            ),
          )
        : const CommonNull();
  }
}
