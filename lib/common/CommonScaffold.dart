import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';

class CommonScaffold extends StatelessWidget {
  CommonScaffold({
    super.key,
    required this.body,
    this.appBarInfo,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.padding,
    this.leading,
  });

  Widget? bottomNavigationBar;
  Widget body;
  AppBarInfoClass? appBarInfo;
  bool? resizeToAvoidBottomInset;
  Widget? floatingActionButton, leading;
  Color? backgroundColor;
  EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.transparent,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBarInfo != null
          ? AppBar(
              foregroundColor: isLight ? appBarInfo!.color : darkTextColor,
              title: CommonText(
                text: appBarInfo!.title,
                initFontSize: appBarInfo!.initFontSize ?? 18,
                isBold: !isLight,
                isNotTr: appBarInfo!.isNotTr,
                color: appBarInfo!.color,
              ),
              centerTitle: appBarInfo!.isCenter,
              actions: appBarInfo!.actions,
              backgroundColor: backgroundColor ?? Colors.transparent,
              scrolledUnderElevation: 0,
              leading: leading,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: padding ?? const EdgeInsets.all(10),
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

// class Fab extends StatelessWidget {
//   Fab({super.key, required this.isFab});

//   bool? isFab;

//   @override
//   Widget build(BuildContext context) {
//     bool isLight = context.watch<ThemeProvider>().isLight;

//     return isFab == true
//         ? MultiValueListenableBuilder(
//             valueListenables: valueListenables,
//             builder: (context, values, child) {
//               DateTime selectedDateTime =
//                   context.watch<SelectedDateTimeProvider>().seletedDateTime;
//               bool isToday =
//                   dateTimeKey(DateTime.now()) == dateTimeKey(selectedDateTime);
//               bool isNotMonth = userRepository.user.calendarFormat !=
//                   CalendarFormat.month.toString();

//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   isNotMonth
//                       ? isToday
//                           ? const CommonNull()
//                           : const TodayButton()
//                       : const CommonNull(),
//                   AddButton(isLight: isLight),
//                 ],
//               );
//             })
//         : const CommonNull();
//   }
// }

// class Bnb extends StatelessWidget {
//   Bnb({super.key, this.bnb});

//   Widget? bnb;

//   @override
//   Widget build(BuildContext context) {
//     return bnb != null
//         ? MultiValueListenableBuilder(
//             valueListenables: valueListenables,
//             builder: (context, values, child) {
//               bool isNotMonth = userRepository.user.calendarFormat !=
//                   CalendarFormat.month.toString();

//               return isNotMonth ? bnb! : const CommonNull();
//             })
//         : const CommonNull();
//   }
// }
