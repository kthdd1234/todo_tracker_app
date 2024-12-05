import 'package:flutter/material.dart';
import 'package:todo_tracker_app/common/CommonNull.dart';
import 'package:todo_tracker_app/util/final.dart';

class GroupOrderButton extends StatelessWidget {
  GroupOrderButton({super.key, required this.isEdit});

  bool isEdit;

  @override
  Widget build(BuildContext context) {
    return isEdit
        ? Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              child:
                  Icon(Icons.reorder_rounded, size: 20, color: grey.original),
            ),
          )
        : const CommonNull();
  }
}
