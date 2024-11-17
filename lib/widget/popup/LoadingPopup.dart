import 'package:flutter/material.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';

class LoadingPopup extends StatelessWidget {
  LoadingPopup({
    super.key,
    required this.text,
    required this.color,
    this.nameArgs,
    this.subText,
  });

  String text;
  Color color;
  String? subText;
  Map<String, String>? nameArgs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(strokeWidth: 3),
          CommonSpace(height: 10),
          CommonText(
            text: text,
            color: color,
            nameArgs: nameArgs,
          ),
          CommonSpace(height: 3),
          subText != null
              ? CommonText(
                  text: subText!,
                  color: color,
                  nameArgs: nameArgs,
                )
              : const CommonNull(),
        ],
      ),
    );
  }
}
