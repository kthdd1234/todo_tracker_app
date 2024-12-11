import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/common/CommonCircle.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';

class PasswordList extends StatelessWidget {
  PasswordList({super.key, required this.isLight, required this.passwordList});

  bool isLight;
  List<String> passwordList;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    onColor(bool isColor) {
      Color lightSelectedColor = isColor ? darkButtonColor : Colors.white;
      Color darkSelectedColor = isColor ? Colors.white : darkNotSelectedBgColor;

      return isLight ? lightSelectedColor : darkSelectedColor;
    }

    Color one = onColor(passwordList.isNotEmpty);
    Color two = onColor(passwordList.length > 1);
    Color three = onColor(passwordList.length > 2);
    Color four = onColor(passwordList.length > 3);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonCircle(color: one, size: 21),
        CommonSpace(width: 10),
        CommonCircle(color: two, size: 21),
        CommonSpace(width: 10),
        CommonCircle(color: three, size: 21),
        CommonSpace(width: 10),
        CommonCircle(color: four, size: 21),
      ],
    );
  }
}
