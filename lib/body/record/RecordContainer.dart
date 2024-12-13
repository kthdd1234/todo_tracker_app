import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_tracker_app/body/record/recordContainer/RecordContainerItemList.dart';
import 'package:todo_tracker_app/body/record/recordContainer/RecordContainerTitle.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';

class RecordContainer extends StatelessWidget {
  RecordContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [RecordContainerTitle(), RecordContainerItemList()],
      ),
    );
  }
}
