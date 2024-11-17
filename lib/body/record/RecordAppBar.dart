import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_tracker_app/common/CommonSvgText.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/TitleDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/enum.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/popup/CalendarPopup.dart';

class RecordAppBar extends StatefulWidget {
  RecordAppBar({super.key});

  @override
  State<RecordAppBar> createState() => _RecordAppBarState();
}

class _RecordAppBarState extends State<RecordAppBar> {
  onTitleDateTime(DateTime titleDateTime) {
    showDialog(
      context: context,
      builder: (context) => CalendarPopup(
        view: DateRangePickerView.year,
        initialdDateTime: titleDateTime,
        onSelectionChanged: (args) async {
          context
              .read<TitleDateTimeProvider>()
              .changeTitleDateTime(dateTime: args.value);
          context
              .read<SelectedDateTimeProvider>()
              .changeSelectedDateTime(dateTime: args.value);

          navigatorPop(context);
        },
      ),
    );
  }

  onManageGroup() {
    //
  }

  onHorizontalDragEnd(
    DragEndDetails dragEndDetails,
    DateTime selectedDateTime,
  ) {
    double? primaryVelocity = dragEndDetails.primaryVelocity;

    if (primaryVelocity == null) {
      return;
    } else if (primaryVelocity > 0) {
      selectedDateTime = selectedDateTime.subtract(const Duration(days: 1));
    } else if (primaryVelocity < 0) {
      selectedDateTime = selectedDateTime.add(const Duration(days: 1));
    }

    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: selectedDateTime);
    context
        .read<TitleDateTimeProvider>()
        .changeTitleDateTime(dateTime: selectedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    bool isLight = context.watch<ThemeProvider>().isLight;
    DateTime titleDateTime =
        context.watch<TitleDateTimeProvider>().titleDateTime;
    double fontSize = context.watch<FontSizeProvider>().fintSize;

    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: CommonSvgText(
              text: yMFormatter(locale: locale, dateTime: titleDateTime),
              initFontSize: fontSize + 4,
              isNotTr: true,
              textColor: isLight ? darkButtonColor : Colors.white,
              svgWidth: 6,
              svgLeft: 3,
              svgName: 'dir-right-s',
              svgColor: isLight ? darkButtonColor : Colors.white,
              svgDirection: SvgDirectionEnum.right,
              onTap: () => onTitleDateTime(titleDateTime),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onManageGroup,
            child: svgAsset(
              name: 'list-add',
              width: 17,
              color: isLight ? darkButtonColor : Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
