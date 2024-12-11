import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/func.dart';

class SettingSvg extends StatelessWidget {
  SettingSvg({super.key, required this.svg});

  String svg;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeProvider>().isLight;

    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isLight ? Colors.white : darkSvgBgColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: svgAsset(name: svg, width: 17),
      ),
    );
  }
}
