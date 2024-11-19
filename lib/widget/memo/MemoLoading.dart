import 'package:flutter/material.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/common/CommonText.dart';
import 'package:todo_tracker_app/util/final.dart';

class MemoLoading extends StatelessWidget {
  const MemoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: Row(
        children: [
          SizedBox(
            width: 10,
            height: 10,
            child: CircularProgressIndicator(
              color: orange.original,
              strokeWidth: 2,
            ),
          ),
          CommonSpace(width: 10),
          CommonText(text: '메모 저장 중...')
        ],
      ),
    );
  }
}
