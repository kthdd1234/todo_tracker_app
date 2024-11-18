import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/body/CalendarBody.dart';
import 'package:todo_tracker_app/body/RecordBody.dart';
import 'package:todo_tracker_app/body/SettingBody.dart';
import 'package:todo_tracker_app/body/TableBody.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonScaffold.dart';
import 'package:todo_tracker_app/provider/BottomTabIndexProvider.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/PremiumProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/TitleDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/button/FnbButton.dart';
import 'package:todo_tracker_app/widget/button/SpeedDialButton.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.locale});

  String locale;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  initializePremium() async {
    // bool isPremium = await isPurchasePremium();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (mounted) {
    //     context.read<PremiumProvider>().setPremiumValue(isPremium);
    //   }
    // });
  }

  initializeUserInfo() {
    // userMethod.userSnapshots.listen(
    //   (event) {
    //     WidgetsBinding.instance.addPostFrameCallback(
    //       (_) {
    //         Map<String, dynamic>? json = event.data();

    //         if (json != null) {
    //           UserInfoClass userInfo = UserInfoClass.fromJson(json);

    //           if (mounted) {
    //             context
    //                 .read<UserInfoProvider>()
    //                 .changeUserInfo(newuUserInfo: userInfo);

    //             context.read<FontSizeProvider>().setFontSize(userInfo.fontSize);
    //             context.read<ThemeProvider>().setThemeValue(userInfo.theme);

    //             int seletedIdx =
    //                 Provider.of<BottomTabIndexProvider>(context, listen: false)
    //                     .seletedIdx;

    //             if (seletedIdx != 3) {
    //               context
    //                   .read<BottomTabIndexProvider>()
    //                   .changeSeletedIdx(newIndex: userInfo.appStartIndex);
    //             }
    //           }
    //         }
    //       },
    //     );
    //   },
    // ).onError((err) => log('$err'));
  }

  initializeGroupInfo() {
    // categoryMethod.categorySnapshots.listen((event) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     List<CategoryInfoClass> categoryInfoList = [];

    //     for (final doc in event.docs) {
    //       CategoryInfoClass categoryInfo = CategoryInfoClass.fromJson(
    //         doc.data() as Map<String, dynamic>,
    //       );
    //       categoryInfoList.add(categoryInfo);
    //     }

    //     if (mounted) {
    //       context
    //           .read<CategoryInfoListProvider>()
    //           .changeCategoryInfoList(newCategoryInfoList: categoryInfoList);
    //     }
    //   });
    // });
  }

  @override
  void initState() {
    initializePremium();
    initializeUserInfo();
    initializeGroupInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    int seletedIdx = context.watch<BottomTabIndexProvider>().seletedIdx;

    onBottomNavigation(int newIndex) {
      DateTime now = DateTime.now();

      if (newIndex == 0) {
        context
            .read<SelectedDateTimeProvider>()
            .changeSelectedDateTime(dateTime: now);
        context
            .read<TitleDateTimeProvider>()
            .changeTitleDateTime(dateTime: now);
      }

      context
          .read<BottomTabIndexProvider>()
          .changeSeletedIdx(newIndex: newIndex);
    }

    return CommonBackground(
      child: CommonScaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: [
            const RecordBody(),
            const CalendarBody(),
            const TableBody(),
            const SettingBody()
          ][seletedIdx],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: BottomNavigationBar(
            items: getBnbiList(isLight, seletedIdx),
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: seletedIdx,
            onTap: onBottomNavigation,
          ),
        ),
        floatingActionButton: seletedIdx == 0 ? FnbButton() : null,
      ),
    );
  }
}
