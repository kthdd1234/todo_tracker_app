import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/util/func.dart';

class ModalCloseButton extends StatelessWidget {
  const ModalCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return InkWell(
      onTap: () => navigatorPop(context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Icon(
          Icons.close_rounded,
          color: isLight ? grey.s400 : grey.original,
        ),
      ),
    );
  }
}
