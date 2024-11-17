import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/constants.dart';

class CommonPopup extends StatelessWidget {
  CommonPopup({
    super.key,
    required this.insetPaddingHorizontal,
    required this.height,
    required this.child,
  });

  double insetPaddingHorizontal, height;
  Widget child;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      insetPadding: EdgeInsets.symmetric(horizontal: insetPaddingHorizontal),
      shape: roundedRectangleBorder,
      content: Container(
        decoration: BoxDecoration(
          color: isLight ? Colors.white : darkBgColor,
          image: isLight
              ? const DecorationImage(
                  image: AssetImage('assets/images/background-image.png'),
                  fit: BoxFit.cover,
                )
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        height: height,
        child: Padding(padding: const EdgeInsets.all(20), child: child),
      ),
    );
  }
}
