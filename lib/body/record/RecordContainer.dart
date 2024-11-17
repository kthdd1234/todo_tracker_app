import 'package:flutter/cupertino.dart';
import 'package:todo_tracker_app/body/record/widget/RecordContainerItem.dart';
import 'package:todo_tracker_app/body/record/widget/RecordContainerTitle.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';

class RecordContainer extends StatelessWidget {
  const RecordContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      outerPadding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          RecordContainerTitle(),
          RecordContainerItem(),
        ],
      ),
    );
  }
}
