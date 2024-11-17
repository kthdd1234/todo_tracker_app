import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/final.dart';

class CommonDivider extends StatelessWidget {
  CommonDivider({
    super.key,
    this.color,
    this.horizontal,
    this.vertical,
  });

  Color? color;
  double? horizontal, vertical;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal ?? 0,
        vertical: vertical ?? 0,
      ),
      child: Divider(
        color: color ?? (isLight ? indigo.s50 : grey.original.withOpacity(0.5)),
        height: 0,
        thickness: 0.5,
      ),
    );
  }
}
