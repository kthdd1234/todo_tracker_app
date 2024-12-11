import 'package:flutter/cupertino.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonContainer.dart';
import 'package:todo_tracker_app/common/CommonScaffold.dart';
import 'package:todo_tracker_app/common/CommonSpace.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/final.dart';
import 'package:todo_tracker_app/widget/button/BackgroundButton.dart';

class BackgroundPage extends StatelessWidget {
  const BackgroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '배경'),
        body: CommonContainer(
          child: SingleChildScrollView(
            child: Column(
              children: backroundClassList
                  .map(
                    (backgroundList) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(children: [
                        BackgroundButton(
                          path: backgroundList[0].path,
                          name: backgroundList[0].name,
                        ),
                        CommonSpace(width: 20),
                        BackgroundButton(
                          path: backgroundList[1].path,
                          name: backgroundList[1].name,
                        )
                      ]),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
