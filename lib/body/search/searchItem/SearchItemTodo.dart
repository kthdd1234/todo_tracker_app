import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonDivider.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class SearchItemTodo extends StatelessWidget {
  SearchItemTodo({super.key, required this.searchItemTodo});

  SearchItemTodoClass searchItemTodo;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    String locale = context.locale.toString();
    double fontSize = context.watch<FontSizeProvider>().fintSize;
    DateTime dateTime = searchItemTodo.dateTime;
    String mde = mdeFormatter(locale: locale, dateTime: dateTime);

    List<RecordItemClass> recordItemList = searchItemTodo.recordItemList;

    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: mde,
            color: isLight ? textColor : grey.s50,
            isNotTr: true,
          ),
          CommonSpace(height: 10),
          CommonDivider(),
          Column(
            children: recordItemList.map(
              (recordItem) {
                GroupInfoClass groupInfo = recordItem.groupInfo;
                TaskInfoClass taskInfo = recordItem.taskInfo;
                ColorClass color = getColorClass(groupInfo.colorName);
                List<RecordInfoClass> recordInfoList = taskInfo.recordInfoList;
                RecordInfoClass? reocrdInfo = getRecordInfo(
                  recordInfoList: recordInfoList,
                  targetDateTime: dateTime,
                );
                String? mark = reocrdInfo?.mark;
                String? memo = reocrdInfo?.memo;

                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          svgAsset(
                            name: 'mark-${mark ?? 'E'}',
                            width: 12,
                            color: isLight ? color.s400 : color.s200,
                          ),
                          CommonSpace(width: 10),
                          Expanded(
                            child: Container(
                              padding: mark != null
                                  ? const EdgeInsets.symmetric(horizontal: 5)
                                  : null,
                              decoration: mark != null
                                  ? BoxDecoration(
                                      color: isLight ? color.s50 : color.s400,
                                      borderRadius: BorderRadius.circular(3),
                                    )
                                  : null,
                              child: CommonText(
                                text: taskInfo.name,
                                isBold: !isLight,
                                textAlign: TextAlign.left,
                                isNotTr: true,
                              ),
                            ),
                          )
                        ],
                      ),
                      memo != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: CommonText(
                                text: memo,
                                color: Colors.grey,
                                initFontSize: fontSize - 2,
                                isNotTr: true,
                              ),
                            )
                          : const CommonNull()
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
