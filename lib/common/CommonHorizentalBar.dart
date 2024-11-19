import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';

class CommonHorizentalBar extends StatelessWidget {
  CommonHorizentalBar({super.key, required this.colorName, this.height});

  String colorName;
  double? height;

  @override
  Widget build(BuildContext context) {
    ColorClass color = getColorClass(colorName);
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Container(
      width: double.infinity,
      height: height ?? (isLight ? 1 : 0.5),
      decoration: BoxDecoration(
        color: isLight ? color.s50 : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
