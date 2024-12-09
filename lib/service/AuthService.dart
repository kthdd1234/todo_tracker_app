import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_tracker_app/method/UserMethod.dart';
import 'package:todo_tracker_app/page/HomePage.dart';
import 'package:todo_tracker_app/util/class.dart';
import 'package:todo_tracker_app/util/constants.dart';
import 'package:todo_tracker_app/util/func.dart';
import 'package:todo_tracker_app/widget/popup/LoadingPopup.dart';

class AuthService {
  commonSignIn(
    BuildContext context,
    userDetails,
    String loginType,
  ) async {
    try {
      showDialog(
        context: context,
        builder: (context) => LoadingPopup(
          text: '로그인 중...',
          color: Colors.white,
        ),
      );

      String locale = context.locale.toString();
      DateTime createDateTime = DateTime.now();
      String uid = userDetails.uid;
      bool isUser = await userMethod.isUser;

      if (isUser == false) {
        String gid = uuid();

        GroupInfoClass groupInfo = GroupInfoClass(
          gid: gid,
          name: '할 일'.tr(),
          colorName: '남색',
          createDateTime: createDateTime,
          isOpen: true,
          taskInfoList: [],
        );

        UserInfoClass userInfo = UserInfoClass(
          uid: uid,
          loginType: loginType,
          createDateTime: createDateTime,
          appStartIndex: 0,
          groupOrderList: [gid],
          taskOrderList: [],
          fontFamily: initFontFamily,
          background: 'background-image',
          theme: 'light',
          osType: Platform.isIOS ? 'AppStore' : 'GooglePlay',
          titleInfo: TitleInfoClass(title: '할 일 리스트', colorName: '남색'),
          fontSize: defaultFontSize,
          calendarFormat: CalendarFormat.week.toString(),
        );

        await userMethod.addUser(userInfo: userInfo);
        await groupMethod.addGroup(gid: gid, groupInfo: groupInfo);
      }

      navigatorPop(context);
      navigatorRemoveUntil(context: context, page: HomePage(locale: locale));
    } catch (e) {
      navigatorPop(context);
      log('$e');
    }
  }

  signInWithGoogle(BuildContext context) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      GoogleSignIn googleSignIn = GoogleSignIn();

      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );

      UserCredential result =
          await firebaseAuth.signInWithCredential(credential);
      final userDetails = result.user;

      if (userDetails != null) commonSignIn(context, userDetails, 'google');
    } catch (e) {
      log('error => $e');
    }
  }

  signInWithApple(BuildContext context) async {
    try {
      AppleAuthProvider appleProvider = AppleAuthProvider();

      UserCredential result =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);
      final userDetails = result.user;

      if (userDetails != null) commonSignIn(context, userDetails, 'apple');
    } catch (e) {
      log('error => $e');
    }
  }

  // signInWithKakao(BuildContext context) async {
  //   try {
  //     OAuthProvider provider = OAuthProvider("oidc.todo-tracker");
  //     OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
  //     OAuthCredential credential = provider.credential(
  //       idToken: token.idToken,
  //       accessToken: token.accessToken,
  //     );
  //     UserCredential result =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     final userDetails = result.user;

  //     if (userDetails != null) commonSignIn(context, userDetails, 'kakao');
  //   } catch (e) {
  //     log('error => $e');
  //   }
  // }
}
