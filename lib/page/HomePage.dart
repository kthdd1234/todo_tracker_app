import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_tracker_app/body/CalendarBody.dart';
import 'package:todo_tracker_app/body/RecordBody.dart';
import 'package:todo_tracker_app/body/SearchBody.dart';
import 'package:todo_tracker_app/body/SettingBody.dart';
import 'package:todo_tracker_app/common/CommonBackground.dart';
import 'package:todo_tracker_app/common/CommonScaffold.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/provider/MemoInfoListProvider.dart';
import 'package:todo_tracker_app/provider/BottomTabIndexProvider.dart';
import 'package:todo_tracker_app/provider/FontSizeProvider.dart';
import 'package:todo_tracker_app/provider/GroupInfoListProvider.dart';
import 'package:todo_tracker_app/provider/PremiumProvider.dart';
import 'package:todo_tracker_app/provider/SelectedDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/ThemeProvider.dart';
import 'package:todo_tracker_app/provider/TitleDateTimeProvider.dart';
import 'package:todo_tracker_app/provider/UserInfoProvider.dart';
import 'package:todo_tracker_app/service/InterstitialAdService.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/button/FnbButton.dart';

InterstitialAdService interstitialAdService = InterstitialAdService();

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.locale});

  String locale;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  initializePremium() async {
    bool isPremium = await isPurchasePremium();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PremiumProvider>().setPremiumValue(isPremium);
      }
    });
  }

  initializeUserInfo() {
    userMethod.userSnapshots.listen(
      (event) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            Map<String, dynamic>? json = event.data();

            if (json != null) {
              UserInfoClass userInfo = UserInfoClass.fromJson(json);

              if (mounted) {
                context
                    .read<UserInfoProvider>()
                    .changeUserInfo(newuUserInfo: userInfo);

                context.read<FontSizeProvider>().setFontSize(userInfo.fontSize);
                context.read<ThemeProvider>().setThemeValue(userInfo.theme);
              }
            }
          },
        );
      },
    ).onError((err) => log('$err'));
  }

  initializeGroupInfo() {
    groupMethod.groupSnapshots.listen((event) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        List<GroupInfoClass> groupInfoList = [];

        for (final doc in event.docs) {
          GroupInfoClass groupInfo = GroupInfoClass.fromJson(
            doc.data() as Map<String, dynamic>,
          );
          groupInfoList.add(groupInfo);
        }

        if (mounted) {
          context
              .read<GroupInfoListProvider>()
              .changeGroupInfoList(newGroupInfoList: groupInfoList);
        }
      });
    });
  }

  initializeMemoInfo() {
    memoMethod.memoSnapshots.listen(
      (event) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            List<MemoInfoClass> memoInfoList = [];

            for (final doc in event.docs) {
              MemoInfoClass memoInfo = MemoInfoClass.fromJson(
                doc.data() as Map<String, dynamic>,
              );

              memoInfoList.add(memoInfo);
            }
            if (mounted) {
              context
                  .read<MemoInfoListProvider>()
                  .changeMemoInfoList(newMemoInfoList: memoInfoList);
            }
          },
        );
      },
    ).onError((err) => log('$err'));
  }

  @override
  void initState() {
    initializePremium();
    initializeUserInfo();
    initializeGroupInfo();
    initializeMemoInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    int seletedIdx = context.watch<BottomTabIndexProvider>().seletedIdx;
    Color lableColor = isLight ? const Color(0xffB0B9C2) : Colors.white;

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
            const SearchBody(),
            const SettingBody()
          ][seletedIdx],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: BottomNavigationBar(
            items: getBnbiList(isLight, seletedIdx),
            elevation: 0,
            selectedItemColor: lableColor,
            currentIndex: seletedIdx,
            onTap: onBottomNavigation,
          ),
        ),
        floatingActionButton: seletedIdx == 0 ? FnbButton() : null,
      ),
    );
  }
}
