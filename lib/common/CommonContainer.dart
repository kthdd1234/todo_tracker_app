import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';

class CommonContainer extends StatelessWidget {
  CommonContainer({
    super.key,
    required this.child,
    this.innerPadding,
    this.outerPadding,
    this.color,
    this.radius,
    this.onTap,
    this.height,
    this.width,
  });

  Widget child;
  Color? color;
  double? height, radius;
  String? width;
  EdgeInsets? innerPadding, outerPadding;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    // themeContainerColor
    return Padding(
      padding: outerPadding ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width == 'auth' ? null : MediaQuery.of(context).size.width,
          height: height,
          padding: innerPadding ?? const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: color ?? (isLight ? Colors.white : darkContainerColor),
            borderRadius: BorderRadius.circular(radius ?? 10),
          ),
          child: child,
        ),
      ),
    );
  }
}
