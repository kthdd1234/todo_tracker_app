import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/widget/bottomSheet/TaskBottomSheet.dart';
import 'package:todo_tracker_app/widget/button/SpeedDialButton.dart';
import 'package:todo_tracker_app/widget/button/SpeedDialChildButton.dart';

class FnbButton extends StatefulWidget {
  FnbButton({super.key});

  @override
  State<FnbButton> createState() => _FnbButtonState();
}

class _FnbButtonState extends State<FnbButton> {
  // onAddTodo(DateTime initDateTime) {
  //   tTodo.dateTimeList = [initDateTime];

  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) => TaskSettingModalSheet(),
  //   );
  // }

  onAddMemo() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(
    //     builder: (BuildContext context) => MemoSettingPage(
    //       recordBox: record,
    //       initDateTime: initDateTime,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    onAddTodo() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => const TaskBottomSheet(),
      );
    }

    onAddMemo() {
      //
    }

    return SpeedDialButton(
      icon: Icons.add,
      activeBackgroundColor: isLight ? red.s200 : darkButtonColor,
      backgroundColor: isLight ? indigo.s300 : darkButtonColor,
      children: [
        speedDialChildButton(
          isLight: isLight,
          svg: 'plus',
          lable: '할 일 추가',
          color: blue,
          onTap: onAddTodo,
        ),
        speedDialChildButton(
          isLight: isLight,
          svg: 'pencil',
          lable: '메모 추가',
          color: orange,
          onTap: onAddMemo,
        ),
      ],
    );
  }
}
