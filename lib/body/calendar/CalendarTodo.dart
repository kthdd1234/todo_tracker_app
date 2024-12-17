import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/body/record/recordContainer/RecordContainerItemList.dart';
import 'package:todo_tracker_app/body/record/recordContainer/item/RecordItemLength.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonDivider.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class CalendarTodo extends StatelessWidget {
  const CalendarTodo({super.key});

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().selectedDateTime;
    bool isLight = context.watch<ThemeProvider>().isLight;
    String mde = mdeFormatter(locale: locale, dateTime: selectedDateTime);

    return CommonContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CommonText(
                text: mde,
                color: isLight ? textColor : grey.s50,
                isNotTr: true,
              ),
              const Spacer(),
              const ReocrdItemLength()
            ],
          ),
          CommonSpace(height: 10),
          CommonDivider(),
          const RecordContainerItemList()
        ],
      ),
    );
  }
}
