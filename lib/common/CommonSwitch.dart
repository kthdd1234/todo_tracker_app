import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';

class CommonSwitch extends StatelessWidget {
  CommonSwitch({
    super.key,
    required this.activeColor,
    required this.value,
    required this.onChanged,
    this.height,
  });

  Color activeColor;
  bool value;
  double? height;
  Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return SizedBox(
      width: 45,
      height: height ?? 25,
      child: CupertinoSwitch(
        trackColor: isLight ? null : darkNotSelectedBgColor,
        activeColor: activeColor,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
